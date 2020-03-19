# Command-line options parser.
abstract class Stag::OptionParser::Base

  macro banner(&block)
    @@banner = {{block.body}}
  end

  # TODO: This is the worst stuff. Just the worst

  macro value(name, short, description, &block)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = {{block.body}}
    end
  end

  macro bool(name, description)
    @parser.on("--{{name.id}}", {{description}}) do
      @options.{{name.id}} = true
    end
  end

  macro bool(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}}", {{description}}) do
      @options.{{name.id}} = true
    end
  end

  macro int(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = parse_int(value)
    end
  end

  macro path(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = parse_path(value)
    end
  end

  macro array(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = parse_array(value)
    end
  end

  macro char(name, description)
    @parser.on("--{{name.id}} VALUE", {{description}}) do |value|
      char = value.chars.first?
      @options.{{name.id}} = char unless char.nil?
    end
  end

  macro string(name, description)
    @parser.on("--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = value.to_s
    end
  end

  macro string(name, short, description)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = value.to_s
    end
  end

  macro string(name, short, description, converter)
    @parser.on("-{{short.id}}", "--{{name.id}} VALUE", {{description}}) do |value|
      @options.{{name.id}} = {{converter.id}}(value.to_s)
    end
  end

  macro options(&block)
    protected def setup_options
      {{block.body}}
    end
  end

  @options   : Options
  @arguments : Arguments
  @parser    = ::OptionParser.new

  def initialize(@arguments, @options)
    setup_banner
    setup_options
    setup_invalid_option_handler
    setup_missing_option_handler
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

  protected def setup_options
    # NOTE: Intentional no-op
  end

  protected def setup_invalid_option_handler
    @parser.invalid_option {} # NOTE: Intentional no-op
  end

  protected def setup_missing_option_handler
    # NOTE: Intentional no-op
  end

  # Helpers # TODO: Concern?

  protected def parse_path(value)
    File.expand_path(value, home: true)
  end

  protected def parse_array(value)
    value.split(",").map(&.strip)
  end

  protected def parse_int(value)
    value.to_i
  end

end

