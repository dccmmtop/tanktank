module Wechat
  class FriendshipsController < Wechat::BaseController
    def index
      if params[:user_id]
        @user = User.find_by_login!(params[:user_id])
        @friendships = @user.friendships.order(created_at: :desc)
      else
        @friendships = current_user.friendships.paginate(page: params[:page], per_page: 15)
      end
      
    end
    
    def show
      @friendship = Friendship.find(params[:id])
      @user = User.find(@friendship.friend_id)
      @passages = @user.passages
    end
  end
end