module Admin
  class MessagesController < Admin::ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
  
    def today_action
      if Message.send_collect_message(current_user.id, wechat_recommendations_path)
        redirect_to(admin_messages_path, notice: '发送成功。')
      else
        redirect_to(admin_messages_path, notice: '发送失败，今日推荐不够三条！')
      end 
    end
  
    def index
      @messages = Message.order(created_at: :desc)
      @messages = @messages.paginate(page: params[:page], per_page: 30)
    end
  
    def show
    end
  
    def new
      @message = Message.new
    end
  
    def edit
    end
  
    def create
      @message = Message.new(params[:message].permit!)
  
      if @message.save
        redirect_to(admin_topic_messages_path, notice: 'Message 创建成功。')
      else
        render action: "new"
      end
    end
  
    def update
      if @message.update_attributes(params[:message].permit!)
        redirect_to(admin_topic_messages_path, notice: 'Message 更新成功。')
      else
        render action: "edit"
      end
    end
  
    def destroy
      @message.destroy
      redirect_to(admin_topic_messages_path, notice: "删除成功。")
    end
  
    private
  
    def set_message
      @message = Message.find(params[:id])
    end
  end
end
