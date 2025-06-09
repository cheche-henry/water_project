Rails.application.routes.draw do
  # Authentication
  post "/login", to: "sessions#create"

  # User management
  resources :users, only: [:index, :show, :destroy]

  # Customer profiles
  resources :customer_profiles, only: [:index, :show, :create, :update, :destroy]

  # Water readings (linked to a customer profile)
  resources :water_readings, only: [:index, :show, :create, :update, :destroy]

  # Bills (linked to customer_profile and water_reading)
  resources :bills, only: [:index, :show, :create, :update, :destroy]

  # Payments (linked to a bill)
  resources :payments, only: [:index, :show, :create, :destroy]

  # Health check route (optional)
  get "up" => "rails/health#show", as: :rails_health_check

  # You can define the root if needed
  # root "welcome#index"
end
