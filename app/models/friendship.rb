class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: "friend_id"
  belongs_to :friend_request
  
  enum access_status: [:qr_code, :share_link, :auto_load]
  
  def year
    self.created_at.strftime('%Y')
  end
  
  def self.multiple_friends(request_id, user_id, token)
    friend_request = FriendRequest.find(request_id)
    friendships = Friendship.where(friend_request_id: friend_request.id, user_id: friend_request.user_id)
    friendships.each do |f| 
      if (f.friend_id != user_id)
       friendship_create(user_id, f.friend_id, friend_request.id, Friendship.access_statuses[:auto_load], token)
     end
    end
  end
  
  def self.friendship_create(user_id, friend_id, request_id, access_id, token)
    friendship = Friendship.find_by(user_id: user_id, friend_id:friend_id)
    if friendship.nil?
      friend_request = FriendRequest.find(request_id)
      if friend_request.access_token == token && Time.now < friend_request.expires_at
        friendship = Friendship.new(event: friend_request.content, user_id: user_id, friend_id: friend_id, friend_request_id: request_id, access_type: access_id)
        if friendship.save
          Friendship.create(event: friend_request.content, user_id: friend_id, friend_id: user_id, friend_request_id: request_id, access_type: access_id)
        end
        friendship
      end
      
    else
      friendship
    end
  end
  
  def self.make_friend(user_id, friend_id, request_id, access_id, token)
    @friendship = friendship_create(user_id, friend_id, request_id, access_id, token)
    friend_request = FriendRequest.find(request_id)
    if friend_request.multiple
      #FriendshipMultipleJob.perform_later(request_id, friend_id, token)
      multiple_friends(request_id, friend_id, token)
    end
    @friendship
  end
      
end
