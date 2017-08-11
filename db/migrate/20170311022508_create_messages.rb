class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :sender
      t.integer :receiver
      t.string :title
      t.text :content
      t.integer :type

      t.timestamps
    end
  end
end
