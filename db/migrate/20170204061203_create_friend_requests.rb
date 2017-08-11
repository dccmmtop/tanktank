class CreateFriendRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_requests do |t|
      t.integer :user_id
      t.string :content

      t.timestamps
    end
    add_index :friend_requests, :user_id
  end
end
