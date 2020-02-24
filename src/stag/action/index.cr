class Stag::Action::Index < Stag::Action::Base

  def call
    puts self.class

    #virtual_manifest = Operation::Generate::VirtualManifest.call(@options)
    #pp virtual_manifest

    query   = Query.preload([:unions, :tags])
    sources = Repository.all(Model::Source, query)

    puts format_table(sources)
  end

  # TODO: Formatter::Base, Formatter::Index::Table, Formatter::Index::CSV, Formatter::Index::Text

  protected def format_table(sources)
    data = sources.map do |source|
      [
        source.name!,
        source.path!,
        source.tags.map(&.path).join("\n")
      ]
    end

    longest_name = sources.map(&.name!.size).max
    longest_path = sources.map(&.path!.size).max
    longest_tag  = sources.map(&.tags.map(&.path!.size)).flatten.max

    table = Tablo::Table.new(data) do |t|
      t.add_column("Name", width: longest_name) { |n| n[0] }
      t.add_column("Path", width: longest_path) { |n| n[1] }
      t.add_column("Tags", width: longest_tag)  { |n| n[2] }
    end

    table.to_s
  end

end

