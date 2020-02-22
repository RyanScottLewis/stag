# Join for Source and Tag models.
class Stag::Model::Union < Crecto::Model

  schema "unions" do
    field :source_id, PkeyValue
    field :tag_id,    PkeyValue
  end

  belongs_to :source, Source
  belongs_to :tag,    Tag

end

