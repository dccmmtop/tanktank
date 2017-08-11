module RecommendationsHelper
  def show_image(topic)
    if topic.cover.url.nil?
      asset_path('getheadimg.jpg') 
    else
      topic.cover.url 
    end
  end
  
  def weekday(index)
    week = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五','星期六']
    week[index]
  end
end
