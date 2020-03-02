class Stag::Formatter::TextTable < Stag::Formatter::Base

  class Params < Formatter::Params

    def initialize(@borders = true)
    end

    property borders

  end

  def initialize(@data, @params = Params.new)
  end

  def call
    headers = @data[0]
    style = @params.borders ? Tablo::STYLE_ALL_BORDERS : ""

    table = Tablo::Table.new(@data[1..-1], connectors: Tablo::CONNECTORS_SINGLE_DOUBLE_MIXED, style: style) do |table|
      headers.each_with_index do |header, index|
        table.add_column(header) { |row| row[index] }
      end
    end.shrinkwrap!

    generate_output(table)
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

