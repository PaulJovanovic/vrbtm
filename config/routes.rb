Vrbtm::Application.routes.draw do
  resources :posts
  resources :sources
  resources :quotes
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  get "sign_in", to: "devise/sessions#new"
  root to: "home#index"
end
