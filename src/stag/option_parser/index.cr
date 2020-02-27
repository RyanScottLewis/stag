# Index action options parser.
class Stag::OptionParser::Index < Stag::OptionParser::Base

  banner do
    <<-STR
    Usage: stag index|list [GLOBAL_OPTIONS] [OPTIONS]

    Display a list of sources.

    Options:
    STR
  end

  protected def setup_options
    @parser.on("-c", "--columns VALUE", "Columns to display") do |value|
      @options.columns = parse_columns(value)
    end
  end

  protected def parse_columns(value)
    value
      .split(",")
      .map(&.strip.downcase)
      .reject(&.empty?)
      .select { |partial| Options::Index::COLUMNS.includes?(partial) }
  end

end

