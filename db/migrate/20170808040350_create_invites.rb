class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.text :context
      t.integer :invitable_id
      t.string :invitable_type
      t.integer :user_id
      t.string :access_token
      t.datetime :expire_at
      t.boolean :multiple, default: true

      t.timestamps
    end
    add_index :invites, [:invitable_id, :invitable_type]
  end
end
