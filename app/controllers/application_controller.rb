class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :apple
  
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
