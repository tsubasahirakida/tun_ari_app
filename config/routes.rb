Rails.application.routes.draw do
  root 'home#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :posts do
    collection do
      get 'character_set'
    end
  end
end
