module Wechat
  class RecommendationsController < Wechat::BaseController
    def index 
      if params[:s].to_s == 'today'
        @topics = Topic.today_recommendations.order(created_at: :desc)  
      else   
        @topics = Topic.where(recommendation: true).order(created_at: :desc)  
      end
    end  
  end
end