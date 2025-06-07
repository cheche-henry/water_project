Rails.application.routes.draw do
  get "customer_profiles/index"
  get "customer_profiles/show"
  get "customer_profiles/create"
  get "customer_profiles/update"
  get "customer_profiles/destroy"
  
  post "/login", to: "sessions#create"
  resources :users, only: [:index, :show, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
