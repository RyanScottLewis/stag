class Stag::Operation::Filesystem::GenerateVirtualManifest < Stag::Operation::Base

  @options : Options
  @tags    = [] of Model::Tag

  def initialize(@options)
  end

  def call
    retrieve_tags
    generate_entries
  end

  protected def retrieve_tags
    query = Query.where(level: 0)#.preload([:unions, :sources, :children])
    @tags = Repository.all(Model::Tag, query)
  end

  protected def generate_entries
    @tags.map do |tag|
      generate_tag_entry(tag)
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
    query = Query.join(:unions).where("unions.tag_id = ?", tag.id)
    Repository.all(Model::Source, query)
  end

  protected def retrieve_children(tag)
    query = Query.where(parent_id: tag.id)
    Repository.all(Model::Tag, query)
  end

  protected def create_directory_entry(tag, memo)
    memo << { type: File::Type::Directory, path: File.join(@options.root, tag.path!) }
  end

  protected def create_symlink_entry(tag, source, memo)
    memo << { type: File::Type::Symlink, path: File.join(@options.root, tag.path!, source.path!) }
  end

end

