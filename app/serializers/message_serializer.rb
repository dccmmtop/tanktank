class MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender, :receiver, :title, :content, :type
end
