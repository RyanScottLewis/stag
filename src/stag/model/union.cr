# Join for Source and Tag models.
class Stag::Model::Union < Crecto::Model

  schema "unions" do
    belongs_to :source, Source
    belongs_to :tag,    Tag
  end

end

