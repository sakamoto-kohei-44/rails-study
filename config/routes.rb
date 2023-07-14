Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]

  # 掲示板関連のルーティング
  resources :boards, only: %i[index new create show edit destroy update] do
    get 'bookmarks', on: :collection
    resource :bookmarks, only: %i[create destroy]
  end

  resources :boards do
    resources :comments, only: %i[create], shallow: true
  end
end
