class Stag::Action::Index < Stag::Action::Base

  def call
    Crecto::DbLogger.set_handler(STDOUT)

    sources = Repository.all(Model::Source, Query.preload(:source_tags))

    # TODO: This works but it should have *just worked* with Query.preload(:tags)
    sources.each do |source|
      query = Query.preload(:source_tags)
      source.tags = source.source_tags.map do |source_tag|
        Repository.get(Model::Tag, source_tag.tag_id)
      end.compact
    end

    puts Formatter::Index::Table.call(sources)
  end

end

