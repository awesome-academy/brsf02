Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    namespace :admin do
      root to: "users#index"
      resources :books
      resources :categories
      resources :users
    end
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :likes
    resources :comments
    resources :books
    resources :book_statuses
    resources :book_favorites
    resources :reviews
    resources :relationships, only: [:create, :destroy]
  end
end
