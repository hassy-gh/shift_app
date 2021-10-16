Rails.application.routes.draw do
  get 'joininigs/new'
  root 'static_pages#home'
  get '/selection', to: 'static_pages#selection'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/join', to: 'joininigs#new'
  post '/join', to: 'joininigs#create'
  patch '/leave', to: 'joininigs#update'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :hope_shifts
  resources :fixed_shifts do
    collection do
      get :day_index
    end
  end
  resources :groups
end
