class Stag::Action::Index < Stag::Action::Base

  def call
    Crecto::DbLogger.set_handler(STDOUT)

    sources = Repository.all(Model::Source, Query.preload(:source_tags))

    # TODO: This works but it should have *just worked* with Query.preload(:tags)
    # Also, it's not optimized by any stretch of the imagination
    sources.each do |source|
      source_tag_ids = source.source_tags.map(&.tag_id)

      unless source_tag_ids.empty?
        query       = Query.where(id: source_tag_ids)
        source.tags = Repository.all(Model::Tag, query)
      end
    end

    puts Formatter::Index::Table.call(sources)
  end

end

