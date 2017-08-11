Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, ENV["WECHAT_APP_ID"], ENV["WECHAT_APP_SECRET"]
  #provider :weixin, ENV["MP_APP_ID"], ENV["MP_APP_SECRET"]
end