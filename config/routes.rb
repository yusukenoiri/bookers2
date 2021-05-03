Rails.application.routes.draw do
  get 'searchs/search'
  # get 'relationships/create'
  # get 'relationships/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  root to: 'home#top'
  devise_for :users

  get 'home/about' => 'home#about'

  resources :users do
    resource:relationships, only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
    # memberメソッドを使うとユーザーidが含まれているURLを扱えるようになる??

  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # 上から順に使われる
end
