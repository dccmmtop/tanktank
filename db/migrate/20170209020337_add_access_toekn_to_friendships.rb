class AddAccessToeknToFriendships < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :access_type, :integer
    add_column :friendships, :access_token, :string
    add_column :friendships, :expires_at, :datetime
    
    add_index :friendships, :access_token
    add_index :friendships, :expires_at
    add_index :friendships, [:access_token, :expires_at]
  end
end
