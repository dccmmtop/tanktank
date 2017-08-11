class Comment < ApplicationRecord
  include MarkdownBody

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :passage

  validates :body, presence: true

  scope :created_by, -> { order(created_at: :desc)}

  before_create :fix_commentable_id
  def fix_commentable_id
    self.commentable_id = commentable_id.to_i
  end

  after_create :increase_counter_cache
  def increase_counter_cache
    return if commentable.blank?
    # commentable.increment!(:comments_count)
  end

  before_destroy :decrease_counter_cache
  def decrease_counter_cache
    return if commentable.blank?
    commentable.decrement!(:comments_count)
  end
  
  def self.notify_comment_created(comment_id)
    comment = Comment.find(comment_id)
    return if comment.blank?
    passage = Passage.find(comment.commentable_id)
    if comment.user_id != passage.user_id
      Notification.create notify_type: 'passage_comment',
                              actor_id: comment.user_id,
                              user_id: passage.user_id,
                              target: comment,
                              second_target: passage
    end
    
  end
  
  after_commit :async_create_comment_notify, on: :create
  def async_create_comment_notify
    NotifyCommentJob.perform_later(id)
  end
end
