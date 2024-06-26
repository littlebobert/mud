url = ENV["REDISCLOUD_URL"]

$redis = Redis.new(url: url, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
end