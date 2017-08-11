require 'will_paginate/array'

module Wechat
  class SearchController < Wechat::BaseController
    def index    
      @items = Search.user_interest_query(current_user.interest).paginate(page: params[:page], per_page: 10)
    end
  end
end