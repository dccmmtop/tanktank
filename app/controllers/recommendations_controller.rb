class RecommendationsController < ApplicationController
  def index
    @topics = Topic.where(recommendation: true).order(created_at: :desc)
    agent = request.user_agent.to_s.downcase 
    if agent.include? 'micromessenger'
      #redirect_to wechat_root_url
      Rails.logger.info("===========> prepare redirect_to wechat_root_url, but cancel")
    end
  end
  
  
  def show
    @topic = Topic.find(params[:id])
  end
end
