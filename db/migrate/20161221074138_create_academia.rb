class CreateAcademia < ActiveRecord::Migration[5.0]
  def change
    create_table :academia do |t|
      t.string :name
      t.string :local
      t.string :code
      t.string :superior_department
      t.string :level
      t.string :remark
      t.string :website
      t.string :address
      t.string :email
      t.string :brief

      t.timestamps
    end
    add_index :academia, :name
  end
end
