Rails.application.routes.draw do
  devise_for :admins, skip: [:registration]
  resources :invoices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "invoices#index"
end
