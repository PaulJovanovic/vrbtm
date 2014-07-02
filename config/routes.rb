Vrbtm::Application.routes.draw do
  post "notifications/:id/read", to: "notifications#read", as: "read_notification"
  get "privacy", to: "home#privacy"
  resources :tags
  get "peoples/search", to: "peoples#search"
  resources :posts do
    resources :comments
  end
  delete "likes", to: "likes#destroy"
  resources :likes
  get "sources/search", to: "sources#search"
  resources :sources
  resources :quotes
  resources :users do
    collection do
      get "search"
    end
    member do
      get "followers"
      get "following"
    end
  end
  resources :relationships, only: [:create, :destroy]
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "sign_in", to: "devise/sessions#new"
  root to: "home#index"
end
