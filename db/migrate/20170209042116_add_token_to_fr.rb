class AddTokenToFr < ActiveRecord::Migration[5.0]
  def change
    add_column :friend_requests, :access_token, :string
    add_column :friend_requests, :expires_at, :datetime
    
    remove_column :friendships, :access_token, :string
    remove_column :friendships, :expires_at, :datetime
    
    add_index :friend_requests, :access_token
    add_index :friend_requests, :expires_at
    add_index :friend_requests, [:access_token, :expires_at]
  end
end
