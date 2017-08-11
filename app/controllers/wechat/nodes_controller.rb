module  Wechat
  class NodesController < Wechat::BaseController
    def new
      @node=Node.new
    end

    def create
      @section=Node.circle
      @node=Node.new(node_params)
      @node.section_id=@section.id
      @node.user_id=current_user.id
      if @node.save 
        @subscription=Subscription.new(user_id:current_user.id,node_id:@node.id,apply_status: Subscription.applications[:passed])
        @subscription.save
        redirect_to(new_wechat_node_url,notice: '创建成功,审核通过后显示')
      else
        redirect_to(new_wechat_node_url,alert: @node.errors.full_messages)
      end
    end

    def time_more
      #显示出当前用户关注的所有圈子的文章,但 不包括公开的圈子的文章
      @topics= current_user.all_topics.paginate(page: params[:page],per_page:30)
    end

    def circle_more
      # 查找我的圈子,包括创建的以及我加入的
      @nodes=[]
      Subscription.where("user_id=? and apply_status=?",current_user.id,Subscription.applications[:passed]).each do |subscription|
        @nodes << Node.find_by(id: subscription[:node_id])
      end
      @nodes
    end
    
    def edit
      @node=Node.find_by(id: params[:id])
    end

    def show
      if current_user.nil?
        redirect_to new_user_session_url 
      else
        @node=Node.find_by(id: params[:id])
        # 不能访问自己没有加入的私密圈子
        if @node.access_level==Node.accesses[:secretive] && !current_user.node_ids.include?(@node.id) 
         redirect_to find_circle_wechat_nodes_url
        end
      end
    end 

    def update
      @node=Node.find_by(id:params[:id])
      if @node.update(node_params)
        redirect_to(wechat_node_url(@node), notice: '修改成功')
      else 
        redirect_to(wechat_node_url(@node), alert: @node.errors.full_messages)
      end
    end

    def find_circle
      #只找圈子
      id=Section.find_by(name:'圈子').id 
      @nodes=Node.where("(access_level=? or access_level=?) and section_id=?",Node.accesses[:semi_public],Node.accesses[:open],id)
      #按关注数量降序排列
      @nodes=@nodes.sort_by {|node| Subscription.where("node_id=? and apply_status=?",node.id,Subscription.applications[:passed]).count*-1}
    end

    def focus
      @node=Node.find_by(id: params[:id])
      @subcription=Subscription.find_by("user_id=? and node_id=?",current_user.id,@node.id)
      #申请关注
      if params[:apply]=="true" 
        #非第一次申请
        if @subcription
          @subcription.update(apply_status: Subscription.applications[:applying])
          #第一次申请
        else
          @subcription=Subscription.new(user_id:current_user.id,node_id:@node.id,apply_status: Subscription.applications[:applying])
          @subcription.save
        end
        redirect_to(wechat_node_url(@node),notice: "申请成功,等待版主同意")
        #直接关注
      elsif params[:apply]=="false"
        #非第一次关注
        if @subcription
          @subcription=Subscription.update(apply_status: Subscription.applications[:passed])
          #第一次关注
        else
          @subcription=Subscription.new(user_id:current_user.id,node_id:@node.id,apply_status:  Subscription.applications[:passed])
          @subcription.save
        end
        redirect_to(wechat_node_url(@node),notice: "关注成功")
        #取消关注
      elsif params[:apply]=="cancel"
        @subcription.destroy
        redirect_to(wechat_node_url(@node),notice: "取消成功")
      end
    end
    # 我收到的申请
    def application_notice
      @application=Node.application(current_user.id)
    end

    def deal_apply
      @subscription=Subscription.find_by("user_id=? and node_id=?",params[:user_id],params[:node_id])
      if params[:result]=="ok"
        @subscription.update(apply_status: Subscription.applications[:passed])
      else
        @subscription.update(apply_status: Subscription.applications[:refuse])
      end
      redirect_to :action=>"application_notice"
    end

    def node_params
      params.require(:node).permit(:access_level,:tag,:name,:section_id,:summary)
    end
  end
end