class AddDateToFriendRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :friend_requests, :started_at, :date
  end
end
