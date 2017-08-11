class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.integer :fee
      t.string :trade_number
      t.string :client

      t.timestamps
    end
  end
end
