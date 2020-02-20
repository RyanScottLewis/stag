class Stag::Operation::SynchronizeFilesystem < Stag::Operation::Base

  @options    : Options
  @tags       = [] of Model::Tag
  @operations = [] of Operation::Filesystem::Base

  def initialize(@options)
  end

  def call
    retrieve_tags
    generate_operations
    call_operations
  end

  protected def retrieve_tags
    query = Query.where(level: 0)#.preload([:unions, :sources, :children])
    @tags = Repository.all(Model::Tag, query)
  end

  protected def generate_operations
    @tags.each do |tag|
      generate_tag_operation(tag)
    end

    @operations
  end

  protected def call_operations
    @operations.each(&.call)
  end

  protected def generate_tag_operation(tag : Model::Tag)
    @operations << Operation::Filesystem::CreateTagDirectory.new(@options, tag)

    # TODO: Figure out preloading because this defeats the purpose of associations...
    query = Query.join(:unions).where("unions.tag_id = ?", tag.id)
    sources = Repository.all(Model::Source, query)

    query = Query.where(parent_id: tag.id)
    children = Repository.all(Model::Tag, query)

    sources.each { |source| generate_source_operation(source, tag) }

    children.each { |child| generate_tag_operation(child) }
  end

  protected def generate_source_operation(source : Model::Source, tag : Model::Tag)
    @operations << Operation::Filesystem::CreateSourceSymlink.new(@options, source, tag)
  end

end

