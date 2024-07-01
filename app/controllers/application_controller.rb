class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
  
  def verified_request?
    controller_name == 'omniauth_callbacks' || super
  end
end
