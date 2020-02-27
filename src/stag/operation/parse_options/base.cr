abstract class Stag::Operation::ParseOptions::Base < Stag::Operation::Base

  @arguments : Arguments
  @parser    : OptionParser

  def initialize(@arguments)
    @parser = OptionParser.new
  end

  def call
    setup_invalid_option_handler
    parse_options
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

