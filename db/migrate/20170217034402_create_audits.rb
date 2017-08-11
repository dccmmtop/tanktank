class CreateAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :audits do |t|
      t.text :content
      t.belongs_to :auditable, :polymorphic => true

      t.timestamps
    end
  end
end
