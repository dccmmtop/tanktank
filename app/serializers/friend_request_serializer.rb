class FriendRequestSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content
end
