class AddUserToKeywords < ActiveRecord::Migration[5.0]
  def change
    add_column :keywords, :user_id, :integer
    add_index :keywords, :user_id
  end
end
