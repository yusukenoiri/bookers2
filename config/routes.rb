Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root to: 'home#top'
  devise_for :users

  get 'home/about' => 'home#about'

  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # 上から順に使われる
end
