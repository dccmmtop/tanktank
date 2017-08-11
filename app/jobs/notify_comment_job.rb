class NotifyCommentJob < ApplicationJob
  queue_as :notifications

  def perform(comment_id)
    Comment.notify_comment_created(comment_id)
  end
end
