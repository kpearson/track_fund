Rails.application.routes.draw do

  root "home#index"

  resources :users, only: [:show, :edit]
  resources :events, except: :index
  resources :people, except: :index
  resources :rsvps, only: :create
  resources :pledges, only: [:create, :new]

  get "dashboard", to: "events#index", as: "dashboard"
  get "login" => "sessions#new_facebook"
  get "logout" => "sessions#destroy"
  put "publish", to: "events#publish", as: "event_publish"

  get "auth/facebook/callback" => "sessions#create"
  get "logout_of_nation" => "users#sign_out_nation"
  get "auth/nationbuilder/callback" => "users#add_user_token"
  get "nationbuilder/auth" => "sessions#new_nation"
end
