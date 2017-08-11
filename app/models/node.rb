class Node < ApplicationRecord
  include Invitable
  acts_as_cached version: 1, expires_in: 1.week

  delegate :name, to: :section, prefix: true, allow_nil: true

  has_many :topics
  has_many :subscriptions
  has_many :users,through: :subscriptions
  belongs_to :section

  validates :name, :summary, :section, presence: true
  validates :name, uniqueness: true,length:{maximum: 20}
  validates :summary ,length:{maximum: 140}

  scope :hots, -> { order(topics_count: :desc) }
  scope :sorted, -> { order(sort: :desc) }
  scope :circle_sorted, -> { order(created_at: :desc)}

  after_save :update_cache_version
  after_destroy :update_cache_version

  enum access:[:secretive,:semi_public,:open]
  
  after_commit :async_create_node_notify, on: :create
  
  def async_create_node_notify
    NotifyNodeJob.perform_later(id)
  end

  def self.find_builtin_node(id, name)
    node = self.find_by_id(id)
    return node if node
    self.create(id: id, name: name, summary: name, section: Section.default)
  end

  def self.circle
    Section.find_by(name:'圈子') || Section.create(name:'圈子')
  end

  # 内建 [招聘] 节点
  def self.job
    @job ||= self.find_builtin_node(25, '招聘')
  end

  # 内建 [NoPoint] 节点
  def self.no_point
    @no_point ||= self.find_builtin_node(61, 'NoPoint')
  end

  # 我收到的申请
  def self.application(user_id)
    subscriptions=[]
    Node.where("user_id=?",user_id).each do |node|
      Subscription.where("node_id=? and apply_status=?",node.id,Subscription.applications[:applying]).order(created_at: :desc).each do |sub|
        subscriptions << sub
      end
    end
    subscriptions
  end
  
  
  def self.notify_node_created(node_id)
    node = Node.find_by_id(node_id)
    Rails.logger.info(node.name)
    return unless node && User.find_by_id(node.user_id)

    follower_ids = User.find_by_id(node.user_id).follower_ids.uniq
    return if follower_ids.empty?

    # 给关注者发通知
    default_note = { notify_type: 'node', target_type: 'Node', target_id: node.id, actor_id: node.user_id }
    Notification.bulk_insert(set_size: 100) do |worker|
      follower_ids.each do |uid|
        note = default_note.merge(user_id: uid)
        worker.add(note)
      end
    end
    true
  end

  # 是否 Summary 过多需要折叠
  def collapse_summary?
    @collapse_summary ||= self.summary_html.scan(/\<p\>|\<ul\>/).size > 2
  end

  def update_cache_version
    # 记录节点变更时间，用于清除缓存
    CacheVersion.section_node_updated_at = Time.now
  end

  # Markdown 转换过后的 HTML
  def summary_html
    Rails.cache.fetch("#{cache_key}/summary_html") do
      Homeland::Markdown.call(summary)
    end
  end

  def watch_count
    Subscription.where("node_id=? and apply_status=?",self.id,Subscription.applications[:passed]).count
  end

end
