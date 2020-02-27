class Stag::Action::Index < Stag::Action::Base

  @sources        = [] of Model::Source
  @action_options = Options::Index.new

  def call
    parse_options
    retrieve_sources
    print_table
  end

  protected def parse_options
    Operation::ParseOptions::Index.call(@arguments, @action_options, OptionParser.new) # TODO: NOT THIS but here to compile
  end

  protected def retrieve_sources
    @sources = Operation::RetrieveSources.call
  end

  protected def print_table
    puts Formatter::Index::Table.call(@action_options, @sources)
  end

end

