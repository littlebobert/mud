Rails.application.config.middleware.use OmniAuth::Builder do
  provider :apple, ENV['APPLE_SERVICE_BUNDLE_ID'], '', {
    scope: 'email name',
    team_id: ENV['APPLE_APP_ID_PREFIX'],
    key_id: ENV['APPLE_KEY_ID'],
    pem: ENV['APPLE_P8_FILE_CONTENT_WITH_EXTRA_NEWLINE'],
    redirect_uri: ENV['APPLE_REDIRECT_URI'],
    client_options: {
      site: 'https://appleid.apple.com',
      authorize_url: 'https://appleid.apple.com/auth/authorize',
      token_url: 'https://appleid.apple.com/auth/token'
    }
  }
end

OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

# This ensures that the CSRF token is passed to OmniAuth
OmniAuth.config.before_request_phase do |env|
  request = ActionDispatch::Request.new(env)
  env['omniauth.origin'] = request.base_url
  env['omniauth.params'] = request.params
end