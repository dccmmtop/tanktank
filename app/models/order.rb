class Order < ApplicationRecord
  
  class << self
    def payment(openid)
      fee = 10
      order_sn = DateTime.now.strftime("%Y%m%d%H%M%S")
      payment_params = { 
        body: "会员升级消费了#{fee}元",
        out_trade_no: order_sn,
        total_fee: fee,
        spbill_create_ip: '60.205.143.205',
        notify_url: 'http://60.205.143.205/wechat/orders/notify',
        trade_type: 'JSAPI', # could be "JSAPI", "NATIVE" or "APP",
        openid: openid  # required when trade_type is `JSAPI`
      }   
      
      r = WxPay::Service.invoke_unifiedorder payment_params
      if r.success? # => true
        timeStamp = Time.now.to_i.to_s
        nonceStr = SecureRandom.uuid.tr('-', '') 
        params = { 
          appId: r['appid'],
          timeStamp: timeStamp,
          nonceStr: nonceStr,
          package: "prepay_id=#{r['prepay_id']}",
          signType: 'MD5'
        }   
        paySign = WxPay::Sign.generate(params)
        result = { "prepay_id" => r["prepay_id"], "timeStamp" => timeStamp, "nonceStr" => nonceStr, "paySign" => paySign, "return_code" => r["return_code"], "return_msg" => r[""], "package" => "prepay_id=#{r['prepay_id']}", "signType" => "MD5"}      
      else
        result = { "return_code" => r["return_code"], "return_msg" => r["return_msg"], "result_code" => r["result_code"], "err_code" => r["err_code"], "err_code_des" => r["err"]}
      end 
      Rails.logger.info("====>#{result}")
      result
    end
  end
end
