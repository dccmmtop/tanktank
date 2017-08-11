class FriendshipMultipleJob < ApplicationJob
  queue_as :friendship_multiple

  def perform(requestid, user_id, token)
    Rails.logger.info("============== PERFORM  multiple ")
    Friendship.multiple_friends(requestid, user_id, token)
  end
end
