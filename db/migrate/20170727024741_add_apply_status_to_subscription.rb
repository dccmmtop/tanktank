class AddApplyStatusToSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions,:apply_status,:integer,default: 2
  end
end
