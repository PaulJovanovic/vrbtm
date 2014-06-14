Vrbtm::Application.routes.draw do
  resources :tags
  get "peoples/search", to: "peoples#search"
  resources :posts
  delete "likes", to: "likes#destroy"
  resources :likes
  get "sources/search", to: "sources#search"
  resources :sources
  resources :quotes
  get "users/search", to: "users#search"
  resources :users
  resources :relationships, only: [:create, :destroy]
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "sign_in", to: "devise/sessions#new"
  root to: "home#index"
end
