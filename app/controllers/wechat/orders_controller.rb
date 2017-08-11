module Wechat
  class OrdersController < Wechat::BaseController
    
    def index
      
    end
    
    def new
      @order = Order.new
      @pay = Order.payment(Authorization.where(user_id: current_user.id).first.openid)
    end
    
    
    def create
    end
    
    def notify
      result = Hash.from_xml(request.body.read)["xml"]
      if WxPay::Sign.verify?(result)
        # find your order and process the post-paid logic.
        render :xml => {return_code: "SUCCESS"}.to_xml(root: 'xml', dasherize: false)
      else
        render :xml => {return_code: "FAIL", return_msg: "签名失败"}.to_xml(root: 'xml', dasherize: false)
      end
    end
    
    
  end
  
end
