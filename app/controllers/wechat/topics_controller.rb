module Wechat
  class TopicsController < Wechat::BaseController
     
    def welcome    
      if current_user.interest
        @items = Search.user_interest_query(current_user.interest).first(5)
      end
      @keywords = Keyword.get_hot
      @topics = Topic.last_actived.without_suggest
      @topics =
        if current_user
          @topics.without_nodes(current_user.blocked_node_ids)
            .without_users(current_user.blocked_user_ids)
        else
          @topics.without_hide_nodes
        end
      @topics = @topics.fields_for_list
      @topics = @topics.paginate(page: params[:page], per_page: 5, total_entries: 1500).to_a
      @page_title = t('menu.topics')
      fresh_when([@topics])         
    end 
    
    def follow_tag
      if params[:q].kind_of?(Array)
        query = params[:q].join(",")
        current_user.update_attributes(interest: query)
      end
    end 
     
    def collect_tag
      if params[:q].present?
        if current_user.interest.length > 0
          current_interest = "#{current_user.interest}" +"," + "#{params[:q].to_s}"
          current_user.update_attributes(interest: current_interest)
        else
          current_user.update_attributes(interest: params[:q].to_s)
        end
        Keyword.set_interest(current_user, params[:q].to_s)
      end
      redirect_to welcome_wechat_topics_url
    end 
     
    def index
      # 从圈子详情页进来
      if params[:node_id] 
        if current_user.nil?
          redirect_to new_user_session_url
        else
          access_level=Node.find(params[:node_id].to_i).access_level
          #当前用户关注的圈子
          node_ids=current_user.node_ids 
          # 没有加入半公开的
          if access_level==Node.accesses[:semi_public] && !node_ids.include?(params[:node_id].to_i)
            #只显示三条
            @topics=Topic.where(:node_id=> params[:node_id]).order(created_at: :desc).limit(3)
            params[:info]="非圈子成员中查看三篇文章"
            @topics=@topics.paginate(page: params[:page],per_page:3)
          # 如果是公开的圈子,或者已经加入的私密的圈子,或者加入半公开的圈子
          elsif access_level==Node.accesses[:open] || ((access_level==Node.accesses[:secretive] || access_level==Node.accesses[:semi_public])&& node_ids.include?(params[:node_id].to_i)) 
            @topics=Topic.where(:node_id=> params[:node_id]).order(created_at: :desc)
            params[:info]="本圈子下共有#{@topics.size}篇文章"
            @topics=@topics.paginate(page: params[:page],per_page:30)
          #url被篡改
          else 
            redirect_to find_circle_wechat_nodes_url
          end
        end
      else #从资讯进来
        params[:info]="最新资讯"
        @topics=Topic.all.select{|topic| topic.recommendation==true || topic.node.section.name != '圈子' }
        # @topics = Topic.last_actived.without_suggest
        # @topics =
        # if current_user
        #   @topics.without_nodes(current_user.blocked_node_ids)
        #   .without_users(current_user.blocked_user_ids)
        # else
        #   @topics.without_hide_nodes
        # end
        # @topics = @topics.fields_for_list
        @topics = @topics.paginate(page: params[:page], per_page: 30)
        @page_title = t('menu.topics')
        fresh_when([@topics])
      end
    end
     
    def show
      @topic = Topic.unscoped.find(params[:id])
      #用户没有关注 文章所在的圈子,并且该圈子是私密的或者是半公开的,则不能访问此文章
      redirect_to find_circle_wechat_nodes_url if !current_user.node_ids.include?(@topic.node_id) && (@topic.node.access_level ==Node.accesses[:secretive] || @topic.node.access_level ==Node.accesses[:semi_public])
      render_404 if @topic.deleted?
      @topic.hits.incr(1)
      @node = @topic.node
      @show_raw = params[:raw] == '1'
      @can_reply = can? :create, Reply

      @replies = Reply.unscoped.where(topic_id: @topic.id).without_body.order(:id).all

       #check_current_user_liked_replies
       #check_current_user_status_for_topic
       #set_special_node_active_menu
      fresh_when([@topic, @node, @show_raw, @replies, @has_followed, @has_favorited, @can_reply])
    end

    def new
      @topic = Topic.new(user_id: current_user.id,node_id:params[:node_id])
    end

    def create
      @topic=Topic.new(topic_params)
      @topic.summary=@topic.body.to_s[0,15] if @topic.body.length>15
      @topic.user_id=current_user.id
      if @topic.save
        redirect_to(wechat_topic_url(@topic))
      else 
        redirect_to(new_wechat_topic_url(:node_id=>@topic.node.id),alert:"发表失败"+@topic.errors.full_messages.to_s)
      end
    end

    def topic_params
      params.require(:topic).permit(:title, :body, :node_id,:summary, :source, :tags)
    end

  end
end