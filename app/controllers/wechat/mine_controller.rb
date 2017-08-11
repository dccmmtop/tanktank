module Wechat
  class MineController < Wechat::BaseController
    
    
    def welcome
      if current_user
        redirect_to wechat_user_url(current_user)
      else
        
      end
    end
    
    def send_friend_request
      if current_user && current_user.id == params[:uid].to_i
        if params[:request_id]
          @fr = FriendRequest.find(params[:request_id].to_i)
          @content = @fr.content
          @date = @fr.started_at
        else
          @content = params[:event].to_s
          @date = params[:date].to_s
          if params[:multiple]
            @multiple = true
          else
            @multiple = false
          end
          @fr = FriendRequest.new(content: @content, user_id: params[:uid].to_i, started_at: @date, multiple: @multiple )
          @fr.save
          redirect_to action: "send_friend_request", uid: params[:uid], event: params[:event], request_id: @fr.id, access: Friendship.access_statuses[:share_link], token: @fr.access_token
        end
        
      else
        redirect_to action: "friend", uid: params[:uid], event: params[:event], request_id: params[:request_id], access: Friendship.access_statuses[:share_link], token: params[:token]
      end
    end
    
    def friend_requests
      @frs = FriendRequest.find_by(user_id: current_user.id)
    end
    
    def acquaint 
      @friends = current_user.friendships.order('id DESC').limit(3)
      @frs = current_user.friend_requests.order('id DESC').limit(3)
    end
    
    def friend
      if params[:uid] && params[:event] && params[:request_id] && params[:access] && params[:token]
        if params[:uid].to_i != current_user.id
          @user = User.find(params[:uid])
          @friendship = Friendship.make_friend(params[:uid].to_i, current_user.id, params[:request_id].to_i, params[:access].to_i, params[:token])
          @fr = FriendRequest.find(params[:request_id].to_i)
          if @friendship && @friendship.friend_request_id != @fr.id
            @fr = FriendRequest.find(@friendship.friend_request_id)
          end
          @fr
        end
      end 
    end
    
  end
end