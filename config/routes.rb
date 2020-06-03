Rails.application.routes.draw do
  resources :categories
  root to: 'products#index'
  resources :products, only: [:new, :create, :destroy, :edit, :update]
  get "products/search", to: "products#search", as: :search_products
end
