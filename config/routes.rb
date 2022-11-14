Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  resources :posts
  get 'posts/:id/review/add', to: 'posts#new_review'
  post 'posts/:id/review/create', to: 'posts#create_review'
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  get 'signoff', to: 'sessions#signoff'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  root :to => redirect('/posts')
end
