Rails.application.routes.draw do

  devise_for :users
  resources :movies
  resources :checkouts
  root 'movies#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
