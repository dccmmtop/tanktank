class Audit < ApplicationRecord
  belongs_to :auditable, :polymorphic => true
  
  scope :created_order, -> { order(created_at: :desc)}
end
