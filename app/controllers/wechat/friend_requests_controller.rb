module Wechat
  class FriendRequestsController < Wechat::BaseController
    
    before_action :get_user, only:[:edit, :update]
    before_action :get_friend_request, only:[:edit, :show, :update]
    
    def index
      @friend_requests = FriendRequest.where(user_id: current_user.id).order(created_at: :desc)
      if @friend_requests
        @friend_requests = @friend_requests.paginate(page: params[:page], per_page: 15) 
      end
      
    end
    
    def update
      if @friend_request.update_attributes(params[:friend_request].permit!)
        @friend_request.friendships.each do |f|
          f.update_attributes(event: @friend_request.content)
        end
        redirect_to(wechat_user_friendships_path(@user), notice: '更新成功。')
      else
        redirect_to(wechat_user_friendships_path(@user), notice: '更新失败。')
      end
    end
    
    def edit
    end
    
    def show
    end
    
    private
      def get_user
        @user = User.find_by_login!(params[:user_id])
      end 
      
      def get_friend_request
        @friend_request = FriendRequest.find(params[:id])
      end
  end
end