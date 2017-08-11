class NotifyNodeJob < ApplicationJob
  queue_as :notifications

  def perform(node_id)
    Node.notify_node_created(node_id)
  end
  
end


