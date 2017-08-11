class Invite < ApplicationRecord
  belongs_to :invitable, polymorphic: true
  belongs_to :user
  
  before_save :default_token
    
  def default_token
    token = "#{self.invitable_type},#{self.invitable_id},#{self.user_id},#{self.expire_at}"
    self.access_token ||= sha_token(token)
  end
  
  def sha_token t
    Digest::SHA1.hexdigest(t)
  end
end
