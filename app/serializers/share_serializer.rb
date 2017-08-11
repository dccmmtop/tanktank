class ShareSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :friend_id, :event_id, :event
end
