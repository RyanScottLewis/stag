class Stag::Formatter::Index::Table < Stag::Formatter::Base

  @sources : Array(Model::Source)

  def initialize(@sources)
  end

  def call
    data  = generate_table_data
    table = generate_table(data)

    #table.to_s
    output = String.build do |output|
      table.each_with_index do |row, i|
        output << table.horizontal_rule(Tablo::TLine::Mid) if i > 0 && (i % 3) != 0 && table.style =~ /ML/i
        output << "\n"
        output << row
        output << "\n"
      end
      output << table.horizontal_rule(Tablo::TLine::Bot) if table.style =~ /BL/i
      output << "\n"
    end
  end

  protected def generate_table_data
    @sources.map do |source|
      tags = source.tags?
      tags = tags.nil? ? "" : tags.map(&.path).join("\n")

      [
        source.name!,
        source.path!,
        tags
      ]
    end
  end

  protected def generate_table(data)
    # TODO: Can't Tablo auto-size columns?
    longest_name = @sources.map(&.name!.size).max
    longest_path = @sources.map(&.path!.size).max
    #longest_tag  = @sources.map(&.tags.map(&.path!.size)).flatten.max
    longest_tag  = @sources.map(&.tags?).compact.flatten.map(&.path!.size).max

    Tablo::Table.new(data) do |t|
      t.add_column("Name", width: longest_name) { |n| n[0] }
      t.add_column("Path", width: longest_path) { |n| n[1] }
      t.add_column("Tags", width: longest_tag)  { |n| n[2] }
    end
  end

end

