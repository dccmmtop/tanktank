class CreateOrganisations < ActiveRecord::Migration[5.0]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :full_name
      t.string :industry
      t.string :area
      t.string :market_value
      t.string :price_to_earning
      t.string :main_product
      t.string :email
      t.string :concept
      t.string :city
      t.string :public_trade_type
      t.string :public_trade_place
      t.string :website
      t.string :registration_address
      t.string :legal_representative
      t.string :chairman
      t.string :brief
      t.string :fax
      t.string :telephone
      t.string :office_address
      t.string :scope
      t.string :ticker

      t.timestamps
    end
    add_index :organisations, :name
    add_index :organisations, :ticker
  end
end
