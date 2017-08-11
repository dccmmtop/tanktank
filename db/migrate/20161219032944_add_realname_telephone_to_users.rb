class AddRealnameTelephoneToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :realname, :string
    add_column :users, :telephone, :string
  end
end
