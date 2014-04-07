Vrbtm::Application.routes.draw do
  resources :posts
  resources :sources
  resources :quotes
  resources :users
  resources :relationships, only: [:create, :destroy]
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  get "sign_in", to: "devise/sessions#new"
  get "users/search", to: "users#search"
  root to: "home#index"
end
