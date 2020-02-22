# Parses options from the application's arguments destructively.
class Stag::Operation::ParseOptions < Stag::Operation::Base

  @arguments : Arguments
  @options   : Options
  @parser    : OptionParser

  def initialize(@arguments, @options, @parser)
  end

  def call
    setup_banner
    setup_options
    setup_invalid_option_handler

    parse_options
  end

  protected def setup_banner
    @parser.banner = "Usage: stag [OPTIONS]" # TODO: Magic string - Use like Stag::NAME or something
  end

  protected def setup_options
    @parser.on("-h", "--help",           "Show help")                               {         @options.help     = true }
    @parser.on("-v", "--verbose",        "Run verbosely")                           {         @options.verbose  = true }
    @parser.on("-D", "--dry",            "Run without making changes")              {         @options.dry      = true }
    @parser.on("-r", "--root VALUE",     "Root path for generating tag filesystem") { |value| @options.root     = value }
    @parser.on("-d", "--database VALUE", "Path to the SQLite databsae")             { |value| @options.database = value }
  end

  protected def setup_invalid_option_handler
    @parser.invalid_option do |flag| # TODO: Just warn
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts @parser
      exit(1)
    end
  end

  protected def parse_options
    @parser.parse(@arguments)
  end

end

