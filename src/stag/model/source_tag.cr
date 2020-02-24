# Join for Source and Tag models.
class Stag::Model::SourceTag < Crecto::Model

  schema "source_tags" do
    belongs_to :source, Source
    belongs_to :tag,    Tag
  end

end

