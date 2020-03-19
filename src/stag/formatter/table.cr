class Stag::Formatter::Table < Stag::Formatter::Base

  def call
    data    = generate_data
    headers = data[0]
    style   = @options.table_borders ? Tablo::STYLE_ALL_BORDERS : ""

    table = Tablo::Table.new(data[1..-1], connectors: Tablo::CONNECTORS_SINGLE_DOUBLE_MIXED, style: style) do |table|
      headers.each_with_index do |header, index|
        table.add_column(header) { |row| row[index] }
      end
    end.shrinkwrap!

    generate_output(table)
  end

  protected def generate_data
    columns = @options.columns
    columns = Options::COLUMNS.clone if columns.empty?

    headers = columns.map { |column| format_header(column) }

    data = @sources.map do |source|
      tags              = Operation::GenerateTags.call(source)
      virtual_hierarchy = Operation::GenerateVirtualHierarchy.call(source, tags)

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

  protected def format_header(value)
    ["vfs", "id"].includes?(value) ? value.upcase : value.capitalize
  end

  protected def generate_output(table)
    output = String.build do |output|
      table.each_with_index do |row, i|
        output << table.horizontal_rule(Tablo::TLine::Mid) + "\n" if i > 0 && table.style =~ /ML/i
        output << row.to_s + "\n"
      end
      output << table.horizontal_rule(Tablo::TLine::Bot) + "\n" if table.style =~ /BL/i
    end
  end

end

