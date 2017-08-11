module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def self.provides_callback_for(*providers)
      providers.each do |provider|
        class_eval %{
          def #{provider}
            Rails.logger.info("------------------------- > provider: #{provider} ")
            if not current_user.blank?
              current_user.bind_service(env["omniauth.auth"])#Add an auth to existing
              redirect_to edit_user_registration_path, notice: "成功绑定了 #{provider} 帐号。"
            else
              @user = User.find_or_create_for_#{provider}(env["omniauth.auth"])

              if @user.persisted?
                flash[:notice] = t('devise.sessions.signed_in')
                Rails.logger.info("------------------------- >provider: #{provider}  return user")
                # sign_in_and_redirect @user, event: :authentication 
                sign_in @user
                redirect_to wechat_me_url   
              else
                redirect_to new_user_registration_url
              end
            end
          end
        }
      end
    end

    provides_callback_for :github, :twitter, :douban, :google, :wechat, :wechat_qr 

    # This is solution for existing accout want bind Google login but current_user is always nil
    # https://github.com/intridea/omniauth/issues/185
    def handle_unverified_request
      true
    end
  end
end
