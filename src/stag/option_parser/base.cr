# Command-line options parser.
abstract class Stag::OptionParser::Base

  macro banner(&block)
    @@banner = {{block.body}}
  end

  macro bool(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}}", {{description}}) do
      @options.{{name.id}} = true
    end
  end

  macro path(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = parse_path(value)
    end
  end

  macro array(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.columns = parse_array(value)
    end
  end

  macro string(name, short, description, converter)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.columns = {{converter.id}}(value)
    end
  end

  macro options(&block)
    protected def setup_options
      {{block.body}}
    end
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

  protected def parse_path(value)
    File.expand_path(value, home: true)
  end

  protected def parse_array(value)
    value.split(",").map(&.strip)
  end

end

