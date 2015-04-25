Rails.application.routes.draw do
  root "home#index"
  get 'home/index'

  resources :users, only: [:show, :edit]

  get 'dashboard', to: "dashboard#index", as: "dashboard"
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get "auth/facebook/callback" => "sessions#create"
  get "auth/nationbuilder/callback" => "dashboard#nation_people"
end
