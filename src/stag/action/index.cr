class Stag::Action::Index < Stag::Action::Base

  def call
    parse_options
    format = retrieve_format
    sources = retrieve_sources
    print_data(sources, format)
  end

  protected def parse_options
    @cli.option_parsers[:index].call
  end

  protected def retrieve_format
    @cli.options.format.downcase
  end

  protected def retrieve_sources
    Operation::RetrieveSources.call
  end

  protected def print_data(sources, format)
    formatter = Formatter[format]

    if formatter.nil?
      puts "Error: Unknown formatter" # TODO: Some sort of better error handling
      exit 1
    else
      puts formatter.call(sources, @cli.options)
    end
  end

end

