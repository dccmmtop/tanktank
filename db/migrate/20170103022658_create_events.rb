class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :date
      t.string :address
      t.text :description
      t.text :description_html
      t.string :contact
      t.integer :user_id

      t.timestamps
    end
  end
end
