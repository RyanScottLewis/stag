# A named filesystem item.
class Stag::Model::Source < Crecto::Model

  schema "sources" do
    field :name, String
    field :path, String # File system path # TODO: Index

    has_many :unions, Union
    has_many :tags,   Tag, through: :unions
  end

  validate_required :name
  validate_required :path

end

