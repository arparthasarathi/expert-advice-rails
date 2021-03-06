Rails.application.routes.draw do
  use_doorkeeper

   namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'
      get '/posts/search', to: 'posts#search'
      resources :users
      resources :posts, param: :slug
    end
  end
end
