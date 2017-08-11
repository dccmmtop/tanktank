module Wechat
  class BaseController < ApplicationController
    include ApplicationHelper
    
    layout 'wechat'
    
    before_action :mobileable
    #before_action :authenticate_user!
  end
end