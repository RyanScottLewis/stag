class Stag::Model::Union < Crecto::Model

  schema "unions" do
    field :link_id, PkeyValue
    field :tag_id, PkeyValue
  end

  belongs_to :link, Link
  belongs_to :tag, Tag

end

