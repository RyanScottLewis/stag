class Stag::Model::Target < Crecto::Model

  schema "targets" do
    field :name, String
    field :path, String # File system path # TODO: Index
  end

  has_many :unions, Union
  has_many :tags,   Tag, through: :unions

  validate_required :name
  validate_required :path

end

