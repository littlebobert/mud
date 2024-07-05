Rails.application.config.middleware.use OmniAuth::Builder do
  provider :apple, ENV['APPLE_SERVICE_BUNDLE_ID'], '', {
    scope: 'email',
    team_id: ENV['APPLE_APP_ID_PREFIX'],
    key_id: ENV['APPLE_KEY_ID'],
    pem: ENV['APPLE_P8_FILE_CONTENT_WITH_EXTRA_NEWLINE']
  }
end

previous_before_request_phase = OmniAuth.config.before_request_phase
OmniAuth.config.before_request_phase = -> (env) do
  # This is just in case there was something else configured before
  previous_before_request_phase.call(env) if previous_before_request_phase

  if env['REQUEST_PATH'] == '/users/auth/apple'
    puts "doing the thing"
    # Make sure the session cookie's SameSite option is set to `None` so that when
    # Apple does the callback phase with a POST request, we'll get the session cookie.
    #
    # Ideally, I'd check here if this request is going to Apple and not some other
    # Identity Provider where doing this is not necessary. But I'm not sure how to
    # check for that in here.
    env['rack.session.options']['same_site'] = 'None'
    env['rack.session.options']['secure'] = true
  end
end