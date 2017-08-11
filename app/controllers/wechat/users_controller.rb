# Devise User Controller
module Wechat
  class UsersController < Wechat::BaseController
    
    def speciality
      if params[:user][:speciality]
        current_user.update_attributes(speciality: params[:user][:speciality].to_s)
      end
    end
    
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update_attributes(params[:user].permit!)
        #Keyword.set_interest(@user, @user.interest)
        render 'edit'
      else
        render 'edit'
      end
    end  
    
    def show
      set_user
      @friendships = @user.friendships.limit(3)
      @passages = @user.passages.audited.limit(3)
    end
    
    def set_user
      @user = User.find_by_login!(params[:id])

      # 转向正确的拼写
      if @user.login != params[:id]
        redirect_to user_path(@user.login), status: 301
      end

      @user_type = @user.user_type
      if @user.deleted?
        render_404
      end
    end
   
  end
end
