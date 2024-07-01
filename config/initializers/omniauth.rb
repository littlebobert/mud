Rails.application.config.middleware.use OmniAuth::Builder do
  provider :apple, ENV['APPLE_SERVICE_BUNDLE_ID'], '', {
    scope: 'email name',
    team_id: ENV['APPLE_APP_ID_PREFIX'],
    key_id: ENV['APPLE_KEY_ID'],
    pem: ENV['APPLE_P8_FILE_CONTENT_WITH_EXTRA_NEWLINE'],
    redirect_uri: ENV['APPLE_REDIRECT_URI']
  }
end

OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true