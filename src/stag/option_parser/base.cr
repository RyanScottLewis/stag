# Command-line options parser.
abstract class Stag::OptionParser::Base

  include Concern::ClassCallable

  macro banner(&block)
    @@banner = {{block.body}}
  end

  macro inherited
    @@class_key = {{@type.stringify.split("::").last.underscore.id.symbolize}}

    @cli       : Interface::CLI
    @arguments : Arguments
    @parser    : ::OptionParser
    @options   : Options::{{@type.stringify.split("::").last.id}}

    def initialize(@cli)
      @arguments = @cli.arguments
      @options   = @cli.options[@@class_key].as(Options::{{@type.stringify.split("::").last.id}})
      @parser    = @cli.option_parsers[@@class_key]
    end
  end

  def call
    setup_options
    setup_banner
    setup_invalid_option_handler
    parse_options
  end

  def help
    @parser.to_s
  end

  protected def setup_banner
    @parser.banner = @@banner
  end

  protected def setup_invalid_option_handler
    @parser.invalid_option do |flag|
      # NOTE: Intentional no-op
    end
  end

  protected def parse_options
    @parser.parse(@arguments)
  end

  # Helpers # TODO: Concern?

  protected def expand_path(path)
    File.expand_path(path, home: true)
  end

end

