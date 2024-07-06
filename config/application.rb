require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

class AppleSameSiteMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env['PATH_INFO'] == '/users/auth/apple/callback'
      puts "path had /users/auth/apple, doing the thing"
      puts "headers:"
      puts headers
      set_cookie_header = headers['Set-Cookie']
      if set_cookie_header
        puts "set_cookie_header was true, doing the thing"
        headers['Set-Cookie'] = set_cookie_header.split(';').map do |cookie|
          cookie << '; SameSite=None' unless cookie.include?('SameSite=')
        end.join('; ')
        
        puts "Set-Cookie: ==="
        puts headers['Set-Cookie']
      end
    end

    [status, headers, body]
  end
end

module Mud
  class Application < Rails::Application
    config.action_controller.raise_on_missing_callback_actions = false if Rails.version >= "7.1.0"
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_job.queue_adapter = :sidekiq
    
    config.action_dispatch.cookies_same_site_protection = lambda { |request|
      request.path == '/users/auth/apple' ? :none : :lax
    }
    
    config.middleware.insert_after ActionDispatch::Session::CookieStore, AppleSameSiteMiddleware
  end
end
