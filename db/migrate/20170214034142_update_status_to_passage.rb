class UpdateStatusToPassage < ActiveRecord::Migration[5.0]
  def up
    change_column :passages, :status, :integer, :default => 0
  end

  def down
    change_column :passages, :status, :integer, :default => nil
  end
end
