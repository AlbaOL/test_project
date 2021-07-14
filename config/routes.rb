Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  devise_for :views
  namespace :api do
    namespace :v1 do
      get 'recipes/index'
      post 'recipes/create'
      put '/edit/:id', to: 'recipes#put'
      get '/show/:id', to: 'recipes#show'
      delete '/destroy/:id', to: 'recipes#destroy'
    end
  end
  get '/*path' => 'homepage#index'
  root 'homepage#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
