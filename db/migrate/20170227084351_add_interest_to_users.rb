class AddInterestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :interest, :string
    add_index :users, :interest
  end
  
end
