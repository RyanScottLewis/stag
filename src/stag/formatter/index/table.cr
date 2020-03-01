# TODO: Rename to Source::Table
class Stag::Formatter::Index::Table < Stag::Formatter::Base

  @action_options : Options::Index
  @sources        : Array(Model::Source)

  def initialize(@action_options, @sources)
  end

  def call
    data  = generate_table_data
    table = generate_table(data)

    generate_output(table)
  end

  # TODO: This should be split out into an operation so it can be used in generating HTML tables (for example)
  protected def generate_table_data
    @sources.map do |source|
      tags = source.tags?
      tag_paths = tags.nil? ? [] of String : tags.map(&.path).compact

      virtual_hierarchy = [] of String
      if tag_paths.empty?
        virtual_hierarchy << File.join("/", source.name!)
      else
        virtual_hierarchy += tag_paths.map do |tag_path|
          File.join("/", tag_path, source.name!)
        end
      end

      row = [] of String
      columns = @action_options.columns
      columns = Options::Index::COLUMNS.clone if columns.empty?

      columns.each do |column|
        contents = case column
        when "name" then source.name!
        when "path" then source.path!
        when "tags" then tag_paths.join("\n")
        when "vfs"  then virtual_hierarchy.join("\n")
        end

        row << contents unless contents.nil?
      end

      row
    end
  end

  protected def generate_table(data)
    Tablo::Table.new(data, connectors: Tablo::CONNECTORS_SINGLE_DOUBLE_MIXED) do |table|
      columns = @action_options.columns
      columns = Options::Index::COLUMNS.clone if columns.empty?

      columns.each_with_index do |column, index|
        header = column == "vfs" ? column.upcase : column.capitalize
        table.add_column(header) { |row| row[index] }
      end
    end.shrinkwrap!
  end

  protected def generate_output(table)
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

end

