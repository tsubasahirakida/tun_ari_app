Rails.application.routes.draw do
  root 'home#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  resources :users, only: %i[new create]
  resources :posts do
    collection do
      get 'character_set'
      get 'template_set_new'
      get 'template_set_edit'
      get 'ai_boosting'
      get 'tundere_boosting'
    end
    member do
      patch 'status_update'
    end
  end
  resources :ais, only: %i[create destroy]
  resources :tuns, only: %i[create destroy]
  resources :deres, only: %i[create destroy]
  resources :bookmarks, only: %i[create destroy]
end
