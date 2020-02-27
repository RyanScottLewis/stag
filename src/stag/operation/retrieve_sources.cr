# Retrieve all sources with all tags loaded.
class Stag::Operation::RetrieveSources < Stag::Operation::Base

  # TODO: This works but it should have *just worked* with:
  #     @sources = Repository.all(Model::Source, Query.preload(:tags))
  def call
    sources = Repository.all(Model::Source, Query.preload(:source_tags))

    sources.each do |source|
      source_tag_ids = source.source_tags.map(&.tag_id)

      unless source_tag_ids.empty?
        query       = Query.where(id: source_tag_ids)
        source.tags = Repository.all(Model::Tag, query)
      end
    end

    sources
  end

end

