Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, controllers: {
  # sessions: '/sessionss',
  # registrations: 'users/registrations'
  # }
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  
  resources :users
  resources :books
  # 上から順に使われる
end
