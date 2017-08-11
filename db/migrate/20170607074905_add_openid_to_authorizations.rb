class AddOpenidToAuthorizations < ActiveRecord::Migration[5.0]
  def change
    add_column :authorizations, :openid, :string
    add_index :authorizations, :openid
  end
end
