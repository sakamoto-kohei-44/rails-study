Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]

  # 掲示板関連のルーティング
  resources :boards do
    resources :comments, only: %i[create]
    collection do
      get :bookmarks
    end
  end

  resources :boards do
    resources :comments, only: %i[create], shallow: true
  end
end
