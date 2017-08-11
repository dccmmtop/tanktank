class AddAuditStatusToAudit < ActiveRecord::Migration[5.0]
  def change
    add_column :audits, :status, :integer
  end
end
