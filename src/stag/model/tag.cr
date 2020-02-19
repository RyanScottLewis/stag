class Stag::Model::Tag < Crecto::Model

  schema "tags" do
    field :name, String
    field :path, String # Tag hierarchy path # TODO: Index
    field :level, Int32
  end

  has_many :unions, Union
  has_many :links, Link, through: :unions

  validate_required :name
  validate_required :path
  validate_required :level

end

