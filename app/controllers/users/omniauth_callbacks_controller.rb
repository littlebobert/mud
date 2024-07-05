class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:apple, :failure]
  
  def apple
    raise
  end

  def failure
    Rails.logger.error("OmniAuth failure: #{failure_message}")
    redirect_to root_path, alert: "Authentication failed, please try again."
  end

  private

end