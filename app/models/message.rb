class Message < ApplicationRecord
  include Rails.application.routes.url_helpers
  validates :sender, presence: true
  validates :receiver, presence: true
  validates :title, presence: true
  
  def self.send_single_message(topic, sender, link)
    $wechat_client = WeixinAuthorize::Client.new("wx21b42616aa23cc24", "31b92fd1e3f48dfdcdf4d7dd4ac218fe")
    data = self.single_data(topic.title)
    
    receiver = "ogJsEv5F3QrbAxvaLj3G4yCrn7Wc"
    $wechat_client.send_template_msg(
      receiver, 
      "JZzk04kBsVFZApcWGb6AYPNL9VbaXTmIi-DNKduruY0", 
      link, 
      "#173177",
      data
    )
    Message.create(sender: sender, receiver: 2, title: topic.title)
  end
  
  def self.single_data(title) 
    data = {
          title: {
            value: title,
            color: "#173277"
          }
        }
    data
  end
  
  def self.collect_data(title1, title2, title3) 
    data = {
          title1: {
            value: title1,
            color: "#173277"
          },
          title2: {
            value: title2,
            color: "#173277"
          },
          title3: {
            value: title3,
            color: "#173277"
          }
        }
    data
  end
  
  def self.send_collect_message(sender, link)
    $wechat_client = WeixinAuthorize::Client.new("wx21b42616aa23cc24", "31b92fd1e3f48dfdcdf4d7dd4ac218fe")
    topics = Topic.today_recommendations
    if topics.count >= 3
      data = self.collect_data(topics[0].title, topics[1].title, topics[2].title) 
      receiver = "ogJsEv5F3QrbAxvaLj3G4yCrn7Wc"
      $wechat_client.send_template_msg(
        receiver, 
        "JZzk04kBsVFZApcWGb6AYPNL9VbaXTmIi-DNKduruY0", 
        link, 
        "#173177",
        data
      )
      Message.create(sender: sender, receiver: 2, title: "#{topics[0].title}/#{topics[1].title}/#{topics[2].title}")
      true
    else
      false
    end
  end
end
