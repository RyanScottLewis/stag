class Stag::Formatter::Index::Table < Stag::Formatter::Base

  @sources : Array(Model::Source)

  def initialize(@sources)
  end

  def call
    data  = generate_table_data
    table = generate_table(data)

    table.to_s
  end

  protected def generate_table_data
    @sources.map do |source|
      [
        source.name!,
        source.path!,
        source.tags.map(&.path).join("\n")
      ]
    end
  end

  protected def generate_table(data)
    # TODO: Can't Tablo auto-size columns?
    longest_name = @sources.map(&.name!.size).max
    longest_path = @sources.map(&.path!.size).max
    longest_tag  = @sources.map(&.tags.map(&.path!.size)).flatten.max

    Tablo::Table.new(data) do |t|
      t.add_column("Name", width: longest_name) { |n| n[0] }
      t.add_column("Path", width: longest_path) { |n| n[1] }
      t.add_column("Tags", width: longest_tag)  { |n| n[2] }
    end
  end

end

