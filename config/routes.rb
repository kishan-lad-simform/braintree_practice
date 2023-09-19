Rails.application.routes.draw do
  get 'transactions/new'
  devise_for :users
  resources :movies
  resources :transactions, only: [:new, :create]
  root 'movies#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
