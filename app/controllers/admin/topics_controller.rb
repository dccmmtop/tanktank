module Admin
  class TopicsController < Admin::ApplicationController
    before_action :set_topic, only: [:show, :edit, :update, :destroy, :undestroy, :suggest, :unsuggest, :push]

    def index
      @topics = Topic.unscoped.order(id: :desc)
      @topics = @topics.paginate(page: params[:page], per_page: 30)
    end

    def show
    end

    def new
      @topic = Topic.new
    end

    def edit
    end

    def create
      @topic = Topic.new(params[:topic].permit!)

      if @topic.save
        redirect_to(admin_topics_path, notice: 'Topic was successfully created.')
      else
        render action: 'new'
      end
    end

    def update
      if @topic.update_attributes(params[:topic].permit!)
        redirect_to(admin_topics_path, notice: 'Topic was successfully updated.')
      else
        render action: 'edit'
      end
    end

    def destroy
      @topic.destroy_by(current_user)

      redirect_to(admin_topics_path)
    end

    def undestroy
      @topic.update_attribute(:deleted_at, nil)
      redirect_to(admin_topics_path)
    end

    def suggest
      @topic.update_attribute(:suggested_at, Time.now)
      redirect_to(@topic, notice: "Topic:#{params[:id]} suggested.")
    end

    def unsuggest
      @topic.update_attribute(:suggested_at, nil)
      redirect_to(@topic, notice: "Topic:#{params[:id]} unsuggested.")
    end

    def push
      link = "#{Setting.domain}#{topic_path(@topic)}"
      if Message.send_single_message(@topic, current_user.id, link)
        redirect_to(admin_topics_path, notice: "推送成功.")
      else
        redirect_to(admin_topics_path, notice: "推送失败.")
      end
    end

    private

    def set_topic
      @topic = Topic.unscoped.find(params[:id])
    end
  end
end
