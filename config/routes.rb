Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  resources :posts
  root :to => redirect('/posts')
end
