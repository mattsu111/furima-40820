Rails.application.routes.draw do
  devise_for :users
root 'items#index'
resources :purchase_records, only: [:index, :create] 
end
