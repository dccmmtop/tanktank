class AddMultiFriendToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :friend_requests, :multiple, :boolean, :default => false
  end
end
