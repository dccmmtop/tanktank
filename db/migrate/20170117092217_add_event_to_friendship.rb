class AddEventToFriendship < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :event, :string
  end
end
