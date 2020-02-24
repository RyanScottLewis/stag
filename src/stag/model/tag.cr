# A hierarchical tag.
class Stag::Model::Tag < Crecto::Model

  schema "tags" do
    field :name,      String
    field :path,      String # Tag hierarchy path # TODO: Index
    field :level,     Int32

    has_many :unions,  Union
    has_many :sources, Source, through: :unions

    belongs_to :parent, Tag, foreign_key: :parent_id
    has_many :children, Tag, foreign_key: :parent_id
  end

  validate_required :name
  validate_required :path
  validate_required :level

end

