class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def apple
    Rails.logger.info("OmniAuth callback for Apple")
    Rails.logger.info("OmniAuth auth hash: #{request.env['omniauth.auth'].inspect}")
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Apple') if is_navigational_format?
    else
      session['devise.apple_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    Rails.logger.error("OmniAuth failure: #{failure_message}")
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end