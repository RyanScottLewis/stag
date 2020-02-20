class Stag::Operation::GenerateFilesystemOperations < Stag::Operation::Base

  @tags = [] of Model::Tag

  def initialize()
  end

  def call
    retrieve_tags
    #generate_operations
  end

  protected def retrieve_tags
    query = Query.where(level: 0).preload([:unions, :sources, :parent, :children])
    @tags = Repository.all(Model::Tag, query)
  end

  protected def generate_operations

  end

  protected def generate_tag_operation(link : Model::Source)
  end

  protected def generate_source_operation(source : Model::Source)
    #source      = link.path
    #destination = [root, path, link.name].compact.join(?/)

    #memo << FileSystemOperation.new(node, source: source, destination: destination)
  end

end

