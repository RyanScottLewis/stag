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
    end
  end

  protected def generate_tag_entry(tag : Model::Tag, memo = [] of FilesystemEntry)
    memo << { type: File::Type::Directory, path: File.join(@options.root, tag.path!) }

    # TODO: Figure out preloading because this defeats the purpose of associations...
    query = Query.join(:unions).where("unions.tag_id = ?", tag.id)
    sources = Repository.all(Model::Source, query)

    query = Query.where(parent_id: tag.id)
    children = Repository.all(Model::Tag, query)

    sources.each do |source|
      memo << { type: File::Type::Symlink, path: File.join(@options.root, tag.path!, source.path!) }
    end

    children.each { |child| generate_tag_entry(child, memo) }

    memo
  end

end

