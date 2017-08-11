class FriendRequest < ApplicationRecord
  has_many :friendships
  belongs_to :user
  before_create :generate_token

  protected

  def generate_token
    self.access_token = SecureRandom.urlsafe_base64
    generate_token if FriendRequest.exists?(access_token: self.access_token)
    self.expires_at = Time.now + 36.hours
  end
end
