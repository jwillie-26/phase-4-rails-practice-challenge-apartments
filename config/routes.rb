Rails.application.routes.draw do
  resources :leases, only: [:index, :show, :create, :update, :destroy]
  resources :apartments, only: [:index, :show, :create, :update, :destroy]
  resources :tenants, only: [:index, :show, :create, :update, :destroy]
end