class Stag::Action::Index < Stag::Action::Base

  def call
    parse_options
    sources = retrieve_sources
    print_table(sources)
  end

  protected def parse_options
    OptionParser::Index.call(@cli)
  end

  protected def retrieve_sources
    Operation::RetrieveSources.call
  end

  protected def print_table(sources)
    puts Formatter::Index::Table.call(@cli.options[:index], sources)
  end

end

