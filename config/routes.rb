Rails.application.routes.draw do
  # --- Autenticación ---
  devise_for :users

  # --- Rutas de Inicio (Root) ---
  devise_scope :user do
    # Si el usuario no está autenticado, la raíz será la página de login.
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    # Si el usuario ya está autenticado, la raíz será el dashboard.
    authenticated :user do
      root 'pages#home', as: :authenticated_root
    end
  end

  # --- Recursos Principales ---
  resources :tickets do
    member do
      get :download_pdf
      get :edit_billing
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

  # --- Recursos de Administración ---
  namespace :admin do
    resources :users
    get 'dashboard', to: 'dashboard#index' # Si tienes un dashboard de admin
  end

  # --- Otros Recursos ---
  resources :products
  resources :location_groups
  resources :locations
  resources :service_types
  resources :ticket_statuses
  resources :teams
  resources :team_memberships
  resources :ticket_products
  resources :ticket_status_logs

  # --- API para Dropdowns Dinámicos ---
  namespace :api do
    resources :teams, only: [] do
      resources :service_types, only: :index
    end
    resources :location_groups, only: [] do
      resources :locations, only: :index
    end
  end

  # --- Health Check ---
  get "up" => "rails/health#show", as: :rails_health_check
end