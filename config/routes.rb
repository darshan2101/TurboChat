Rails.application.routes.draw do
  resources :rooms do
    resources :messages
    collection do
      post 'search'
    end
  end
  root 'pages#home'

  # paths for joining and leaving room
  get 'rooms/join/:id' ,to: 'rooms#join' ,as: 'join_room'
  get 'rooms/leave/:id' ,to: 'rooms#leave' ,as: 'leave_room'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'user/:id', to: 'users#show', as: 'user'
  # Defines the root path route ("/")
  # root "articles#index"
end
