class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :node

  validates :user_id,:node_id,presence: :true
  enum application: [:applying,:passed,:refuse]
  after_commit :async_subscription_notify
  def async_subscription_notify
    NotifySubscriptionJob.perform_later(id)
  end
  
  def self.notify_subscription_status(subscription_id)
    s = Subscription.find_by_id(subscription_id)
    return unless s && User.find_by(id: s.user_id) && Node.find_by(id: s.node_id)
    node = Node.find_by(id: s.node_id)
    return if s.user_id == node.user_id
    notify_type = ''
    actor_id = s.user_id
    user_id = s.user_id
    case s.apply_status
    
    when Subscription.applications[:applying]
      notify_type = 'node_applied'
      actor_id = s.user_id 
      user_id = node.user_id
    when Subscription.applications[:passed]
      notify_type = 'node_approvalled'
      
    when Subscription.applications[:refuse]
      notify_type = 'node_declined'
    else
    end
    Notification.create(notify_type: notify_type, target_type: 'Node', target_id: node.id, actor_id: actor_id, user_id: user_id)
    true
  end

end
