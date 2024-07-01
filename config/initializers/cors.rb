Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.production?
      origins 'https://www.tokyo-mud.com', 'https://appleid.apple.com'
      resource '/users/auth/apple/callback',
        headers: :any,
        methods: [:get, :post, :options],
        credentials: true
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: false
    else
      origins 'http://localhost:3000', 'http://127.0.0.1:3000'
      resource '/users/auth/apple/callback',
        headers: :any,
        methods: [:get, :post, :options],
        credentials: true
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: false
    end
  end
end