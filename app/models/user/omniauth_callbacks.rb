class User
  module OmniauthCallbacks
    extend ActiveSupport::Concern

    module ClassMethods
      %w(github wechat wechat_qr).each do |provider|
        define_method "find_or_create_for_#{provider}" do |response|
          uid = response['uid'].to_s
          data = response['info']
          extra = response['extra']['raw_info']
          uid = data['unionid'] if data['unionid'].present?

          Rails.logger.info("------------------------- > uid: #{uid}  unionid: #{data['unionid']}")
          Rails.logger.info("------------------------- > openid: #{extra['openid']}  ")
          if (user = Authorization.find_by(uid: uid).try(:user))
            Authorization.find_by(uid: uid).update_attributes(openid: extra['openid'])
            user
          else
            user = User.new_from_provider_data(provider, uid, data)
            if user.save(validate: false)
              Authorization.find_or_create_by(provider: provider, uid: uid, user_id: user.id, openid: extra['openid'])
              return user
            else
              Rails.logger.warn("User.create_from_hash 失败，#{user.errors.inspect}")
              return nil
            end
          end
        end
      end

      def new_from_provider_data(provider, uid, data)
        User.new do |user|
          user.email =
            if data['email'].present? && !User.where(email: data['email']).exists?
              data['email']
            else
              "#{provider}+#{uid}@example.com"
            end
          
          user.name = data['nickname']
          user.login = "#{provider}_#{uid}"
          user.remote_avatar_url = data['headimgurl']
          
          if provider == 'github'
            user.github = data['nickname']
          end

          if user.login.blank?
            user.login = "u#{Time.now.to_i}"
          end

          if User.where(login: user.login).exists?
            user.login = "#{user.github}-github" # TODO: possibly duplicated user login here. What should we do?
          end

          user.password = Devise.friendly_token[0, 20]
          user.location = data['location']
          user.tagline  = data['description']
        end
      end
    end
  end
end
