Rails.application.routes.draw do
  #mount Avo::Engine, at: Avo.configuration.root_path
  root 'home#top'
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'

  get '/sitemap', to: redirect('https://s3-ap-northeast-1.amazonaws.com/tun-ari-app/sitemaps/sitemap.xml.gz')
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post '/guest_login', to: 'user_sessions#guest_login'
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
      get 'download'
      get 'tweet'
    end
  end
  resources :ais, only: %i[create destroy]
  resources :tuns, only: %i[create destroy]
  resources :deres, only: %i[create destroy]
  resources :bookmarks, only: %i[create destroy]
  resource :profile, only: %i[] do
    collection do
      get 'my_publishpost'
      get 'my_archivepost'
      get 'my_draftpost'
      get 'my_bookmarkpost'
    end
  end
end
