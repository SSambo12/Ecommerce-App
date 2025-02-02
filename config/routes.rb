Rails.application.routes.draw do
  get "products/index"
  get "home", to: "home#index", as: :home
  resource :registrations, only: %i[create new]
  resource :session
  resources :passwords, param: :token
  namespace :admin do
    resources :products do
      resources :stocks
    end
    resources :categories
    resources :orders
  end

  namespace :api do
    namespace :v1 do
      resources :orders
      resources :products
      resources :order_items
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "protected#index"
  get "admin" => "admin#index"

  resources :products, only: [ :show ]

  Rails.application.routes.draw do
    get "admin/index", to: "admin#index", as: "admin_index"
  end
end
