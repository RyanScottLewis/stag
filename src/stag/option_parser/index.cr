# Index action options parser.
class Stag::OptionParser::Index < Stag::OptionParser::Base

  banner do
    <<-STR
    Usage: stag index [OPTIONS]
           stag list [OPTIONS]

    Display a list of sources.

    Action Options:
    STR
  end

  options do
    string :columns, :c, "Columns to display", :parse_columns
  end

  protected def parse_columns(value)
    value
      .split(",")
      .map(&.strip.downcase)
      .reject(&.empty?)
      .select { |partial| Options::COLUMNS.includes?(partial) }
  end

end

