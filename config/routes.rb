Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/auth/apple', to: 'auth#apple_login', as: :apple_login
  root to: "places#home"
  
  resources :places, only: [:show] do
    get "browse_hacker_news", to: "places#browse_hacker_news"
    resources :items, only: [:show, :update]
    resources :chat_messages, only: :create
  end
  
  resources :characters, only: [:show] do
    resources :messages, only: [:create]
  end
  
  resources :quests, only: [] do
    resources :quest_logs, only: [:create, :update]
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
