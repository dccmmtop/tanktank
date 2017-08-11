class NotifySubscriptionJob < ApplicationJob
  queue_as :notifications
  
  def perform(subscription_id)
    Subscription.notify_subscription_status(subscription_id)
  end
end


