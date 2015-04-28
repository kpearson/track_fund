Rails.application.routes.draw do

  resources :people, except: :index

  root "home#index"
  get 'home/index'

  resources :users, only: [:show, :edit]

  get 'dashboard', to: "dashboard#index", as: "dashboard"
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get "auth/facebook/callback" => "sessions#create"
  get "auth/nationbuilder/callback" => "dashboard#add_user_token"
  get "nationbuilder/auth" => "dashboard#new"
  get "logout_of_nation" => "dashboard#sign_out_nation"
end
