class Stag::Action::Index < Stag::Action::Base

  def call
    parse_options
    sources = retrieve_sources
    data = generate_data(sources)
    print_table(data)
  end

  protected def parse_options
    @cli.option_parsers[:index].call
  end

  protected def retrieve_sources
    Operation::RetrieveSources.call
  end

  # TODO: Operation for this sort of thing
  protected def generate_data(sources)
    columns = @cli.options[:index].columns
    columns = Options::Index::COLUMNS.clone if columns.empty?

    headers = columns.map { |column| format_header(column) }

    data = sources.map do |source|
      tags = source.tags?
      tags = tags.nil? ? [] of String : tags.map(&.path).compact

      virtual_hierarchy = [] of String
      if tags.empty?
        virtual_hierarchy << File.join("/", source.name!)
      else
        virtual_hierarchy += tags.map do |tag_path|
          File.join("/", tag_path, source.name!)
        end
      end

      columns.map do |column|
        case column
        when "id"   then source.id.to_s
        when "name" then source.name!
        when "path" then source.path!
        when "tags" then tags.join("\n")
        when "vfs"  then virtual_hierarchy.join("\n")
        else; ""
        end
      end
    end

    data.unshift(headers)

    data
  end

  protected def print_table(data)
    format    = @cli.options[:global].format.downcase
    formatter = Formatter[format]

    if formatter.nil?
      puts "Error: Unknown formatter" # TODO: Some sort of better error handling
      exit 1
    else
      puts formatter.call(data, @cli.options[:global])
    end
  end

  protected def format_header(value)
    ["vfs", "id"].includes?(value) ? value.upcase : value.capitalize
  end

end
