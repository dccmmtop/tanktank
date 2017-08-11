module Wechat
  class InvitesController < Wechat::BaseController
    def new
      @invite=Invite.new
    end

    def create
      @node=Node.find(params[:node_id])
      @invite=@node.invites.create(invite_params)
      redirect_to action: "share",uid:@node.user_id,nid: @node.id,token: @invite.access_token,deadline: @invite.expire_at.to_s[0,10]
    end

    def share

      redirect_to new_user_session_url if current_user.nil?
      # 邀请链接的创建人访问此页面时
      if current_user.id==params[:uid].to_i
        params[:role]='create_user'
      #加入者访问此页面
      else
        # 如果能找到邀请记录
        if @invite=Invite.find_by("user_id=? and invitable_id=? and access_token=?" ,params[:uid],params[:nid],params[:token])
          # 在有效期内
          if @invite.expire_at >= Time.now
          params[:role]='legal_user'
          #链接失效
          else 
          params[:role]='invalid'
          end
        # 没有找到邀请记录,链接被篡改了
        else
          params[:role]='illegal_user'
        end
      end  
    end

    def invite_params
      params.require(:invite).permit(:context,:expire_at,:multiple,:invitable_id,:invitable_type,:node_id,:user_id)
    end
  end
end