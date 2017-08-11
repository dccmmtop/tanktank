class OrganisationSerializer < ActiveModel::Serializer
  attributes :id, :name, :full_name, :website
end
