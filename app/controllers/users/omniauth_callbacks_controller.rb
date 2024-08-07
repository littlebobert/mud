class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_forgery_protection only: [:apple, :failure]
  
  def apple
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Apple") if is_navigational_format?
    else
      session["devise.apple_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    Rails.logger.error("OmniAuth failure: #{failure_message}")
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
  
  private
    
  def verified_request?
    action_name == 'apple' || super
  end

end