class Stag::Action::Index < Stag::Action::Base

  @sources = [] of Model::Source

  def call
    retrieve_sources
    print_table
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
    puts Formatter::Index::Table.call(@options, @sources)
  end

end

