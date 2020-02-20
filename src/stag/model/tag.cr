class Stag::Model::Tag < Crecto::Model

  schema "tags" do
    field :name, String
    field :path, String # Tag hierarchy path # TODO: Index
    field :level, Int32
    field :parent_id, PkeyValue
  end

  has_many :unions, Union
  has_many :links, Link, through: :unions

  has_one :parent, Tag, foreign_key: :parent_id

  validate_required :name
  validate_required :path
  validate_required :level

end

