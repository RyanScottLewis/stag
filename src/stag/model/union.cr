class Stag::Model::Union < Crecto::Model

  schema "unions" do
    field :target_id, PkeyValue
    field :tag_id,    PkeyValue
  end

  belongs_to :target, Target
  belongs_to :tag,    Tag

end

