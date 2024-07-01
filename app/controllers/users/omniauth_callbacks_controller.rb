class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def apple
    # Verify the callback state
    unless valid_apple_callback?(request.env['omniauth.params']['state'])
      return head(:forbidden)
    end
  
    # Your existing callback handling code
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
  
  def valid_apple_callback?(state)
    stored_state = session.delete('omniauth.state')
    stored_state.present? && stored_state == state
  end
  
  # Override CSRF verification for Apple callback
  def verify_authenticity_token
    super unless action_name == 'apple'
  end

end