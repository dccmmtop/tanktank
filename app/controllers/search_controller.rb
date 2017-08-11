class SearchController < ApplicationController
  before_action :authenticate_user!, only: [:users]

  def index
    if params[:q].kind_of?(Array)
      query = params[:q].join("|")
      Rails.logger.info("================  xx#{query} ")
      @result = Search.query(query, params[:page])

    else
      Rails.logger.info("================  jj ")
      query = params[:q].nil?? '' : params[:q]
      Rails.logger.info("================  jj#{query} ")
      @result = Search.query(query, params[:page])
    end
  end

  def users
    @result = []
    if params[:q].present?
      users = User.prefix_match(params[:q], limit: 100)
      users.sort_by! { |u| current_user.following_ids.index(u['id']) || 9999999999 }
      @result = users.collect { |u| { login: u['title'], name: u['name'], avatar_url: u['large_avatar_url'] } }
    else
      users = current_user.following.limit(10)
      @result = users.collect { |u| { login: u.login, name: u.name, avatar_url: u.large_avatar_url } }
    end
    render json: @result
  end
  
  def keywrod
    @result = Search.query(params[:q], 1)
    render :index
  end
  
  def keywrods
    
    
  end
end
