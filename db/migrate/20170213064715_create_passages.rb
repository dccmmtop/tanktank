class CreatePassages < ActiveRecord::Migration[5.0]
  def change
    create_table :passages do |t|
      t.string :purpose
      t.text :description
      t.string :help
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
