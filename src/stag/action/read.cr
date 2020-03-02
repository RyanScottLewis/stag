class Stag::Action::Read < Stag::Action::Base

  def call
    if @cli.arguments.size == 1
      entry = search_for_entry
      print_entry(entry)
    else
      print_help
    end
  end

  protected def search_for_entry
    query = @cli.arguments.first

    # TODO: possible in SQL?
    sources = Repository.all(Model::Source)
    source_distances = sources.map do |source|
      {
        source: source,
        name: Levenshtein.distance(source.name!, query),
        path: Levenshtein.distance(source.path!, query),
      }
    end

    tags = Repository.all(Model::Tag)
    tag_distances = tags.map do |tag|
      {
        tag: tag,
        name: Levenshtein.distance(tag.name!, query),
        path: Levenshtein.distance(tag.path!, query),
      }
    end

    closest_source_by_name = source_distances.sort_by(&.[:name]).first
    closest_source_by_path = source_distances.sort_by(&.[:path]).first
    closest_tag_by_name    = tag_distances.sort_by(&.[:name]).first
    closest_tag_by_path    = tag_distances.sort_by(&.[:path]).first

    if @cli.options[:global].verbose >= Verbose::DEBUG
      puts "Closest source by name: %s %s - %d" % [closest_source_by_name[:source].name!, closest_source_by_name[:source].path!, closest_source_by_name[:name]] unless closest_source_by_name.nil?
      puts "Closest source by path: %s %s - %d" % [closest_source_by_path[:source].name!, closest_source_by_path[:source].path!, closest_source_by_path[:path]] unless closest_source_by_path.nil?
      puts "Closest tag by name: %s %s - %d" % [closest_tag_by_name[:tag].name!, closest_tag_by_name[:tag].path!, closest_tag_by_name[:name]] unless closest_tag_by_name.nil?
      puts "Closest tag by path: %s %s - %d" % [closest_tag_by_path[:tag].name!, closest_tag_by_path[:tag].path!, closest_tag_by_path[:path]] unless closest_tag_by_path.nil?
    end

    closest_by_type = [
      { record: closest_source_by_name[:source], distance: closest_source_by_name[:name] },
      { record: closest_source_by_path[:source], distance: closest_source_by_name[:path] },
      { record: closest_tag_by_name[:tag],       distance: closest_tag_by_name[:name] },
      { record: closest_tag_by_path[:tag],       distance: closest_tag_by_path[:path] },
    ]

    closest_by_type.sort_by(&.[:distance]).first
  end

  protected def print_help
    puts @cli.option_parsers[:read]
  end

  protected def print_entry(entry)
    case entry[:record]
    when Model::Source
      record             = entry[:record].as(Model::Source)
      record.source_tags = Repository.all(Model::SourceTag, Query.where(source_id: record.id))
      source_tag_ids     = record.source_tags.map(&.tag_id)
      record.tags        = Repository.all(Model::Tag, Query.where(id: source_tag_ids))

      tags = record.tags?
      tags = tags.nil? ? [] of String : tags.map(&.path).compact

      virtual_hierarchy = [] of String
      if tags.empty?
        virtual_hierarchy << File.join("/", record.name!)
      else
        virtual_hierarchy += tags.map do |tag_path|
          File.join("/", tag_path, record.name!)
        end
      end

      data = [
        ["ID", "Name", "Path", "Tags", "VFS"],
        [record.id.to_s, record.name!, record.path!, tags.join("\n"), virtual_hierarchy.join("\n")]
      ]

      puts Operation::FormatData.call(data, "text", Formatter::TextTable::Params.new)
    when Model::Tag
      record = entry[:record].as(Model::Tag)

      data = [
        ["ID", "Name", "Path"],
        [record.id.to_s, record.name!, record.path!]
      ]

      puts Operation::FormatData.call(data, "text", Formatter::TextTable::Params.new)
    end
  end

end

