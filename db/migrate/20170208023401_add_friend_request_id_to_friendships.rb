class AddFriendRequestIdToFriendships < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :friend_request_id, :integer    
    add_index :friendships, :friend_request_id
  end
end
