Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  resources :posts
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  get 'signoff', to: 'sessions#signoff'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  root :to => redirect('/posts')
end
