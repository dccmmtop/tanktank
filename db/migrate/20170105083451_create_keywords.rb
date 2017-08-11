class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.integer :using_count, :default => 0

      t.timestamps
    end
    add_index :keywords, :name
    add_index :keywords, :using_count
  end
end
