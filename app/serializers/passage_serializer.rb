class PassageSerializer < ActiveModel::Serializer
  attributes :id, :purpose, :description, :help, :status, :user_id
end
