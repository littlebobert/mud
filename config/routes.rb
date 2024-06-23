Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: "places#home"
  
  resources :places, only: [:show] do
    get "browse_hacker_news", to: "places#browse_hacker_news"
    resources :items, only: [:show, :update]
  end
  
  resources :characters, only: [:show] do
    resources :messages, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
