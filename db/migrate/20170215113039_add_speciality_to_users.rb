class AddSpecialityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :speciality, :string
  end
end
