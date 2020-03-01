# Command-line options parser.
abstract class Stag::OptionParser::Base

  macro banner(&block)
    @@banner = {{block.body}}
  end

  macro inherited
    @options : Options::{{@type.stringify.split("::").last.id}}
  end

  @arguments : Arguments
  @parser    = ::OptionParser.new

  def initialize(@arguments, @options)
    setup_banner
    setup_options
    setup_invalid_option_handler
  end

  def call
    @parser.parse(@arguments)
  end

  def to_s(io : IO)
    @parser.to_s(io)
  end

  protected def setup_banner
    @parser.banner = @@banner
  end

  protected def setup_invalid_option_handler
    @parser.invalid_option {} # NOTE: Intentional no-op
  end

  # Helpers # TODO: Concern?

  protected def expand_path(path)
    File.expand_path(path, home: true)
  end

end

