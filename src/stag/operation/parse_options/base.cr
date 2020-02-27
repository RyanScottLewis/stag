# TODO: Rename @options to @global_options
abstract class Stag::Operation::ParseOptions::Base < Stag::Operation::Base

  @arguments : Arguments
  #@options   : Options::Base # NOTE: Intentionlly commented out - but still unsure
  @parser    : OptionParser

  macro banner(&block)
    @@banner = {{block.body}}
  end

  macro type(class_type)
    @options : {{class_type}}
  end

  def initialize(@arguments, @options)
    @parser = OptionParser.new
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
    # TODO: Magic string - Use like Stag::NAME or something
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

