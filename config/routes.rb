Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  
  get 'homes/about' => 'homes#about'
  
  resources :users
  resources :books
  # 上から順に使われる
end
