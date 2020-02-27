class Stag::Action::Index < Stag::Action::Base

  @sources        = [] of Model::Source
  @action_options = Options::Index.new

  def call
    parse_options
    retrieve_sources
    print_table
  end

  protected def parse_options
    Operation::ParseOptions::Index.call(@arguments, @action_options)
  end

  protected def retrieve_sources
    @sources = Repository.all(Model::Source, Query.preload(:source_tags))

    # TODO: This works but it should have *just worked* with Query.preload(:tags)
    @sources.each do |source|
      source_tag_ids = source.source_tags.map(&.tag_id)

      unless source_tag_ids.empty?
        query       = Query.where(id: source_tag_ids)
        source.tags = Repository.all(Model::Tag, query)
      end
    end
  end

  protected def print_table
    puts Formatter::Index::Table.call(@options, @action_options, @sources)
  end

end

