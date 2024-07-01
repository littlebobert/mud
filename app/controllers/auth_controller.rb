class AuthController < ApplicationController
  skip_before_action :authenticate_user!
  
  def apple_login
    redirect_to apple_authorization_url, allow_other_host: true
  end

  private

  def apple_authorization_url
    "https://appleid.apple.com/auth/authorize?" + {
      client_id: ENV['APPLE_SERVICE_BUNDLE_ID'],
      redirect_uri: CGI.escape(apple_callback_url),
      response_type: 'code',
      scope: 'email name',
      response_mode: 'form_post',
      state: SecureRandom.hex(24)
    }.to_query
  end

  def apple_callback_url
    url_for(controller: 'users/omniauth_callbacks', action: 'apple', only_path: false)
  end
end