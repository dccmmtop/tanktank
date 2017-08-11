class Passage < ApplicationRecord
  belongs_to :user
  has_many :audits, :as => :auditable
  has_many :comments, :as => :commentable
  
  scope :auditing, -> { where status: Passage.audit_statuses[:non_audit] }
  scope :audited, -> { where.not(status: Passage.audit_statuses[:non_audit]) }
  validates_presence_of :title, :help
  enum audit_status: [:non_audit, :audit_success, :audit_failure, :close]
  
  def self.search(q)
    datas = Passage.where('title like ?', "%#{q}%")
    datas
  end 
end
