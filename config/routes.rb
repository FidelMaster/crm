Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/new'
    get 'users/create'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
  end
  resources :ticket_status_logs
 
  resources :ticket_products

  resources :tickets do
    member do
      get :edit_billing     # Ruta para mostrar el formulario

      patch :assign_agent
      patch :update_status
      patch :update_billing   
      patch :approve_billing
      patch :reject_billing
      patch :mark_as_paid
    end

    resources :ticket_comments, only: [:create] 
    resources :ticket_products, only: [:create, :destroy]
  end

 namespace :admin do
    resources :users
  end

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

   # Si el usuario no está autenticado, la raíz será la página de login.
  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end

  # Si el usuario ya está autenticado, la raíz será el dashboard.
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

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
