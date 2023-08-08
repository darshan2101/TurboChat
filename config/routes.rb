Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end
  devise_for :users
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get "users", to: "devise/sessions#new"
  end
  resources :users
  # Defines the root path route ("/")
  # root "articles#index"
end
