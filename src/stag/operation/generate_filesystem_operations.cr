class Stag::Operation::GenerateFilesystemOperations < Stag::Operation::Base

  def initialize()
  end

  def call
    # Retrieve all tags
    # Generate all FS operations recursively
  end

  protected def retrieve_tags
    @tags = Repository.all(Model::Tag, Query.where(level: 0).preload([:unions, :links]))
  end

  protected def genreate_operations_for(node)

  end

end

