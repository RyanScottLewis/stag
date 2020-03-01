# Generate FilesystemEntries based on the virtual filesystem.
class Stag::Operation::Generate::VirtualManifest < Stag::Operation::Base

  @options : Options::Global
  @tags    = [] of Model::Tag
  @sources = [] of Model::Source

  def initialize(@options)
  end

  def call
    retrieve_tags
    retrieve_top_level_sources
    generate_entries
  end

  protected def retrieve_tags
    query = Query.where(level: 0)
    @tags = Repository.all(Model::Tag, query)
  end

  # TODO: This is dumb. Should traverse sources, then get tags.
  protected def retrieve_top_level_sources
    # SELECT sources.* FROM sources WHERE id NOT IN (SELECT source_tags.id FROM source_tags)
    query    = Query.where("id NOT IN (SELECT source_tags.id FROM source_tags)")
    @sources = Repository.all(Model::Source, query)
  end

  protected def generate_entries
    @tags.map do |tag|
      generate_tag_entry(tag)
    end.flatten + @sources.map do |source|
      { path: File.join(@options.root, source.name!), target: source.path! }
    end.flatten
  end

  protected def generate_tag_entry(tag : Model::Tag, memo = [] of FilesystemEntry)
    create_directory_entry(tag, memo)

    sources  = retrieve_sources(tag)
    children = retrieve_children(tag)

    sources.each  { |source| create_symlink_entry(tag, source, memo) }
    children.each { |child|  generate_tag_entry(child, memo) }

    memo
  end

  # TODO: Figure out preloading because this defeats the purpose of associations...
  protected def retrieve_sources(tag)
    query = Query.join(:source_tags).where("source_tags.tag_id = ?", tag.id)
    Repository.all(Model::Source, query)
  end

  protected def retrieve_children(tag)
    query = Query.where(parent_id: tag.id)
    Repository.all(Model::Tag, query)
  end

  protected def create_directory_entry(tag, memo)
    memo << { path: File.join(@options.root, tag.path!) }
  end

  protected def create_symlink_entry(tag, source, memo)
    memo << { path: File.join(@options.root, tag.path!, source.name!), target: source.path! }
  end

end

