module Wechat
  class PassagesController < Wechat::BaseController
    before_action :set_passage, only: [:show, :edit, :update, :destroy, :close]
    def index  
      if params[:user_id]
        @user = User.find_by_login!(params[:user_id]) 
        users = []
        @user.friendships.each do |u|
          users << u.friend_id
          Rails.logger.info("=========== friend id is #{u.friend_id}")
          User.find(u.friend_id).friendships.each do |f|
            next if users.include?(f.friend_id)
            users << f.friend_id
            Rails.logger.info("=========== friend 's friend id is #{f.friend_id}")
          end
        end
        users << @user.id
        @passages = Passage.audited.where("user_id in (?)", users).order("id desc").paginate(page: params[:page], per_page: 10) if @user
      else
        @passages = current_user.passages.audited.order("id desc").paginate(page: params[:page], per_page: 10)
      end  
      
    end
    
    def new
      if params[:topic_id]
        topic = Topic.find(params[:topic_id])
        @passage = Passage.new(title: topic.title, description: "更多详情，查看原文 http://#{request.host}:#{request.port}#{wechat_topic_path(topic)}")
      else
        @passage = Passage.new
      end
       
    end
    
    def show
      @shares = Share.where(event_id: params[:id], event: 'Passage')
      @passage
      @comments = @passage.comments
      @comment = Comment.new
      if current_user == @passage.user
        current_user.notifications.unread_comments(@passage.id).each do |n|
          n.update_attributes(:read_at => Time.now)
        end     
      end 
    end
    
    def create
      @passage = Passage.new(params[:passage].permit!)
      @passage.user_id = current_user.id
      if @passage.save
        redirect_to(wechat_passages_path, notice: '创建成功,审核通过后显示')
      else
        render action: "new"
      end
    end
    
    def edit
    end
    
    def update
      @passage.status = Passage.audit_statuses[:non_audit]
      @passage.comment = ''
      if @passage.update_attributes(params[:passage].permit!)
        redirect_to(wechat_passages_path, notice: '编辑成功，审核通过后显示')
      else
        render action: "edit"
      end
    end
    
    def destroy
      if current_user.id  == @passage.user_id
        @passage.destroy
        redirect_to(wechat_passages_path, notice: '删除成功')
      else
        redirect_to(wechat_passages_path)
      end
    end
    
    def close
      @passage.update_attributes(status: Passage.audit_statuses[:close])
      redirect_to(wechat_user_passages_path(current_user), notice: '关闭成功')
    end
    
    private

    def set_passage
      @passage = Passage.find(params[:id])
    end
    
  end
end