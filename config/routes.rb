Rails.application.routes.draw do

  resources :events, except: :index
  get "dashboard", to: "events#index", as: "dashboard"
  resources :people, except: :index
  resources :rsvps, only: :create
  resources :pledges, only: :create

  root "home#index"
  get 'home/index'

  resources :users, only: [:show, :edit]


  get "login" => "sessions#new_facebook"
  get "logout" => "sessions#destroy"
  get "auth/facebook/callback" => "sessions#create"
  get "logout_of_nation" => "users#sign_out_nation"

  get "auth/nationbuilder/callback" => "users#add_user_token"
  get "nationbuilder/auth" => "sessions#new_nation"
end
