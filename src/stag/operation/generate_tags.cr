# Generate tags from a source.
class Stag::Operation::GenerateTags < Stag::Operation::Base

  @source : Model::Source

  def initialize(@source)
  end

  def call
    tags = @source.tags?

    tags.nil? ? [] of String : tags.map(&.path).compact
  end

end

