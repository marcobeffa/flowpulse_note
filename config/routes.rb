Rails.application.routes.draw do
  resources :contents

  namespace :api do
    namespace :v1 do
      resources :profiles  do
        resources :posts, only: [ :index, :show ], module: :profiles
      end
    end
  end

  get "all/:data/:pubblicazione/:visibility/:stato", to: "dashboard#all", as: "all"
  get "past/:data/:pubblicazione/:visibility/:stato", to: "dashboard#past", as: "past"
  get "future/:data/:pubblicazione/:visibility/:stato", to: "dashboard#future", as: "future"




  resources :profiles do
    resources :posts, only: %i[index show]
  end

  namespace :home do
    get :public
  end
  get "utenti", to: "pages#utenti"
  resource :session
  resources :passwords, param: :token
  resource :registration, only: %i[new create edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"
end
