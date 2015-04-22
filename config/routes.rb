Rails.application.routes.draw do
  get 'home/index'
  get 'dashboard/index'
  root "home#index"
end
