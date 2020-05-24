Rails.application.routes.draw do
  root to: 'products#index'
  post 'products', to: 'products#create'
  get 'products/new', to: 'products#new'
end
