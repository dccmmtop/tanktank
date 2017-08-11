if ENV['TRAVIS']
  source 'https://rubygems.org'
else
  source 'https://gems.ruby-china.org'
end

gem 'rails', '~> 5.0.0'
gem 'sprockets'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'jbuilder'
gem 'turbolinks', '~> 5.0.0'
gem 'dropzonejs-rails'

gem 'pg'
gem 'pghero'

gem 'rack-attack'

gem 'rails-i18n'
gem 'http_accept_language'
gem 'twemoji'
gem 'jquery-atwho-rails'
gem 'font-awesome-rails'

# OAuth Provider
gem 'doorkeeper'
gem 'doorkeeper-i18n'

gem 'bulk_insert'

# 上传组件
gem 'carrierwave'
# Aliyun / Upyun 可选项
gem 'carrierwave-upyun'
gem 'carrierwave-aliyun'
# Lazy load
gem 'mini_magick', require: false

# 验证码，头像
gem 'rucaptcha'
gem 'letter_avatar'

# 用户系统
gem 'devise'
gem 'devise-encryptable'

# 通知系统
gem 'notifications'
gem 'ruby-push-notifications'

# 分页
gem 'will_paginate'

# 搜索
gem 'elasticsearch-model', git: 'https://github.com/elasticsearch/elasticsearch-rails'
gem 'elasticsearch-rails', git: 'https://github.com/elasticsearch/elasticsearch-rails'
gem 'redis-search'

# 三方平台 OAuth 验证登陆
gem 'omniauth'
gem 'omniauth-github'
#gem "omniauth-wechat-oauth2", git: 'https://github.com/yangsr/omniauth-wechat-oauth2'

gem "omniauth-wechat-oauth2", git: 'https://github.com/ryan715/omniauth-wechat-oauth2.git'

# 微信
gem 'weixin_authorize'

# Permission
gem 'cancancan'

# Redis
gem 'redis'
gem 'hiredis'
gem 'redis-namespace'
gem 'redis-objects'
gem 'redis-session-store'

# Cache
gem 'second_level_cache'

# Setting
gem 'rails-settings-cached'

# HTML Pipeline
gem 'html-pipeline'
gem 'html-pipeline-rouge_filter'
gem 'redcarpet'
gem 'auto-space'

# 队列
gem 'sidekiq'
# Sidekiq Web
gem 'sinatra', '~> 2.0.0.beta2'

# 分享功能
gem 'social-share-button'

# 表单
gem 'simple_form'

# API
gem 'active_model_serializers'

# Mailer Service
gem 'postmark'
gem 'postmark-rails'

# Dalli, kgio is for Dalli
gem 'kgio'
gem 'dalli'

gem 'puma'

# API cors
gem 'rack-cors', require: 'rack/cors'
gem 'rack-utf8_sanitizer'

gem 'exception_notification'
gem 'status-page'
# for excel
gem 'roo'
gem 'axlsx'

# for markdown
gem 'reverse_markdown'

gem 'bootstrap-datepicker-rails'
gem 'remotipart', '~> 1.2'

gem 'newrelic_rpm'

# wechat pay
gem 'wx_pay'

gem 'bootstrap-tagsinput-rails', git: 'https://github.com/ryan715/bootstrap-tagsinput-rails'

gem 'bundler-audit', require: false

group :development do
  gem 'derailed'
  # Better Errors
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'listen'
  gem 'rubocop', '~> 0.39.0', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'jasmine-rails', '~> 0.10.2'
  gem 'letter_opener'
  gem 'yard'

  gem 'codecov', require: false
  gem 'pry-byebug'
end