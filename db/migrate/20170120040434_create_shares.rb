class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :event_id
      t.string :event

      t.timestamps
    end
    add_index :shares, :user_id
    add_index :shares, :friend_id
  end
end
