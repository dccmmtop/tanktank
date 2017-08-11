class AddInviteIdToSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :invite_id, :integer
    add_index :subscriptions, :invite_id
  end
  
end
