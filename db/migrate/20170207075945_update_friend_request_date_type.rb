class UpdateFriendRequestDateType < ActiveRecord::Migration[5.0]
  def change
    change_column :friend_requests, :started_at, :string
  end
end
