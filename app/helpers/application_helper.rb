module ApplicationHelper
  ALLOW_TAGS = %w(p br img h1 h2 h3 h4 h5 h6 blockquote pre code b i iframe
                  strong em table tr td tbody th strike del u a ul ol li span hr)
  ALLOW_ATTRIBUTES = %w(href src class width height id title alt target rel data-floor frameborder allowfullscreen)
  EMPTY_STRING = ''.freeze

  def markdown(text)
    sanitize_markdown(Homeland::Markdown.call(text))
  end

  def sanitize_markdown(body)
    # TODO: This method slow, 3.5ms per call in topic body
    sanitize(body, tags: ALLOW_TAGS, attributes: ALLOW_ATTRIBUTES)
  end

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger  if type.to_sym == :alert
      text = content_tag(:div, link_to(raw('<i class="fa fa-close"></i>'), '#', :class => 'close', 'data-dismiss' => 'alert') + message, class: "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def admin?(user = nil)
    user ||= current_user
    user.try(:admin?)
  end

  def wiki_editor?(user = nil)
    user ||= current_user
    user.try(:wiki_editor?)
  end

  def owner?(item)
    return false if item.blank? || current_user.blank?
    if item.is_a?(User)
      item.id == current_user.id
    else
      item.user_id == current_user.id
    end
  end

  def timeago(time, options = {})
    return '' if time.blank?
    options[:class] = options[:class].blank? ? 'timeago' : [options[:class], 'timeago'].join(' ')
    options[:title] = time.iso8601
    text = l time.to_date, format: :long
    content_tag(:abbr, text, options)
  end

  def title_tag(str)
    content_for :title, raw("#{str} · #{Setting.app_name}")
  end

  MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' \
                       'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' \
                       'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' \
                       'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' \
                       'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return true if turbolinks_app?
    return false if agent_str =~ /ipad/
    Rails.logger.info("-----------> agentstr    === #{agent_str}")
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

  def mobileable
    agent_str = request.user_agent.to_s.downcase
    session[:topic_id] = params[:id] 
    session[:user_id] = params[:uid]
    session[:event] = params[:event]
    session[:request_id] = params[:request_id]
    session[:access] = params[:access]
    session[:token] = params[:token]
    if params[:controller].to_s.include? "topic"
      session[:action] = "Topic"
    elsif params[:controller].to_s.include? "passage"
      session[:action] = "Passage"
    end
    if agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
      Rails.logger.info("========== controller is #{params[:controller].to_s}")
      if !(params[:controller].to_s.include? "wechat") && (params[:controller].to_s.include? "topic") && session[:topic_id] 
        redirect_to wechat_topic_url(Topic.find(session[:topic_id]), uid: session[:user_id])
      else
        if current_user && Authorization.where(user_id: current_user.id).first.openid.present?
          $wechat_client = WeixinAuthorize::Client.new(Setting.wechat_id, Setting.wechat_secret)
          Rails.logger.info("========== #{$wechat_client.is_valid?}")
          Rails.logger.info("========== It is not first time")
          Rails.logger.info("==========************   Followed_id is #{session[:user_id]}, current user is #{current_user.id}")

          if session[:user_id] && current_user.id != session[:user_id].to_i
            if params[:event]
              if Friendship.find_by(user_id: session[:user_id], friend_id:current_user.id).nil? && session[:user_id]
                @friendship = Friendship.make_friend(params[:uid].to_i, current_user.id, session[:request_id].to_i, session[:access], params[:token])
              end 
            else            
              if params[:controller].to_s == 'topics' 
                if Share.find_by(user_id: session[:user_id], friend_id:current_user.id).nil? 
                  User.find(session[:user_id]).shares.create(friend_id: current_user.id, event: params[:controller].to_s, event_id: session[:topic_id].to_i) if session[:user_id]
                end 
                redirect_to topic_url(Topic.find(session[:topic_id]), uid: current_user.id) if session[:topic_id]
              elsif params[:controller].to_s.include? 'wechat/passages' 
                if Passage.find(session[:topic_id]) && (Passage.find(session[:topic_id]).status == Passage.audit_statuses[:audit_success])
                  if Share.find_by(user_id: session[:user_id], friend_id:current_user.id, event:'Passage', event_id: session[:topic_id].to_i).nil? 
                    User.find(session[:user_id]).shares.create(friend_id: current_user.id, event: 'Passage', event_id: session[:topic_id].to_i) if session[:user_id]
                  end 
                  redirect_to wechat_passage_url(Passage.find(session[:topic_id]), uid: current_user.id) if session[:topic_id]
                else  
                end
              else

              end
            end 
          end
          
        else
          if current_user
            sign_out current_user
          end
          Rails.logger.info("========== It's first time")
          redirect_to user_wechat_omniauth_authorize_url
        end
      end
    end
  end

  # 可按需修改
  LANGUAGES_LISTS = {
    'Ruby'                         => 'ruby',
    'HTML / ERB'                   => 'erb',
    'CSS / SCSS'                   => 'scss',
    'JavaScript'                   => 'js',
    'YAML</i>'                     => 'yml',
    'CoffeeScript'                 => 'coffee',
    'Nginx / Redis <i>(.conf)</i>' => 'conf',
    'Python'                       => 'python',
    'PHP'                          => 'php',
    'Java'                         => 'java',
    'Erlang'                       => 'erlang',
    'Shell / Bash'                 => 'shell'
  }

  def insert_code_menu_items_tag
    lang_list = []
    LANGUAGES_LISTS.each do |k, l|
      lang_list << content_tag(:li) do
        link_to raw(k), '#', data: { lang: l }
      end
    end
    raw lang_list.join(EMPTY_STRING)
  end

  def birthday_tag
    return '' if Setting.app_name != 'Ruby China'
    t = Time.now
    return '' unless t.month == 10 && t.day == 28
    age = t.year - 2011
    title = markdown(":tada: :birthday: :cake:  Ruby China 创立 #{age} 周年纪念日 :cake: :birthday: :tada:")
    raw %(<div class="markdown" style="text-align:center; margin-bottom:15px; line-height:100%;">#{title}</div>)
  end

  def random_tips
    tips = Setting.tips
    return EMPTY_STRING if tips.blank?
    tips.split("\n").sample
  end

  def icon_tag(name, opts = {})
    label = EMPTY_STRING
    if opts[:label]
      label = %(<span>#{opts[:label]}</span>)
    end
    raw "<i class='fa fa-#{name}'></i> #{label}"
  end

  # Override cache helper for support multiple I18n locale
  def cache(name = {}, options = {}, &block)
    options ||= {}
    super([I18n.locale, name], options, &block)
  end

  def render_list(opts = {})
    list = []
    yield(list)
    items = []
    list.each do |link|
      item_class = EMPTY_STRING
      urls = link.match(/href=(["'])(.*?)(\1)/) || []
      url = urls.length > 2 ? urls[2] : nil
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = 'active'
      end
      items << content_tag('li', raw(link), class: item_class)
    end
    content_tag('ul', raw(items.join(EMPTY_STRING)), opts)
  end

  def highlight(text)
    text = escape_once(text)
    text.gsub!('[h]', '<em>')
    text.gsub!('[/h]', '</em>')
    text.gsub!(/\\n|\\r/, '')
    raw text
  end

  def get_qr
    image_tag("qrcode_for_gh_646d6089d139_258.jpg")
  end

  def get_passage_url(description)
    if description.include?('http')
      d = description.split('http://')
      content = "<a href='http://#{d[1]}' target='blank' >#{d[0]}</a>"
    else
      description 
    end
  end

  def status_node (node)
   subscription=Subscription.where("user_id=? and node_id=?",current_user.id,node.id)
   return Subscription.applications[:refuse] if subscription.take.nil? #如果subscription中没有此user与此node对应关系.说明此用户没有关注该node,或者没有提出关注该node的申请
   subscription.take.apply_status
  end
 
end
