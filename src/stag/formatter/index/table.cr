class Stag::Formatter::Index::Table < Stag::Formatter::Base

  @options : Options
  @sources : Array(Model::Source)

  def initialize(@options, @sources)
  end

  def call
    data  = generate_table_data
    table = generate_table(data)

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
      tag_paths = tags.nil? ? [] of String : tags.map(&.path).compact

      virtual_hierarchy = [] of String
      unless tag_paths.empty?
        virtual_hierarchy = tag_paths.map do |tag_path|
          File.join(@options.root, tag_path, source.name!)
        end
      end

      [
        source.name!,
        source.path!,
        tag_paths.join("\n"),
        virtual_hierarchy.join("\n")
      ]
    end
  end

  protected def generate_table(data)
    # TODO: Can't Tablo auto-size columns?
    longest_name = longest_row_element(data, 0)
    longest_path = longest_row_element(data, 1)
    longest_tag  = longest_row_element(data, 2)
    longest_fs   = longest_row_element(data, 3)

    Tablo::Table.new(data) do |t|
      t.add_column("Name", width: longest_name) { |n| n[0] }
      t.add_column("Path", width: longest_path) { |n| n[1] }
      t.add_column("Tags", width: longest_tag)  { |n| n[2] }
      t.add_column("VFS",  width: longest_fs)   { |n| n[3] }
    end
  end

  protected def longest_row_element(data, index)
    column = data.map(&.[index])

    column.map do |element|
      element.lines.map(&.size).max?
    end.compact.max
  end

end

