class Stag::Action::Index < Stag::Action::Base

  def call
    sources = retrieve_sources
    print_table(sources)
  end

  protected def retrieve_sources
    sources = Repository.all(Model::Source, Query.preload(:source_tags))

    # TODO: This works but it should have *just worked* with Query.preload(:tags)
    sources.each do |source|
      source_tag_ids = source.source_tags.map(&.tag_id)

      unless source_tag_ids.empty?
        query       = Query.where(id: source_tag_ids)
        source.tags = Repository.all(Model::Tag, query)
      end
    end

    sources
  end

  protected def print_table(sources)
    puts Formatter::Index::Table.call(@options, sources)
  end

end

