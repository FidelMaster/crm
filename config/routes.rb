Rails.application.routes.draw do
  resources :ticket_status_logs
  resources :ticket_comments
  resources :ticket_products
  resources :tickets
  resources :team_memberships
  resources :teams
  resources :ticket_statuses
  resources :service_types
  resources :locations
  resources :location_groups
  resources :products

  get 'admin/dashboard'
  get 'pages/home'
  devise_for :users

  root "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
 
  get "admin/dashboard", to: "admin#dashboard"
  
  namespace :api do
    resources :teams, only: [] do
      resources :service_types, only: :index
    end

    resources :location_groups, only: [] do
      resources :locations, only: :index
    end
 end

  # Defines the root path route ("/")
  # root "posts#index"
end
