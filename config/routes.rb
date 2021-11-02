Rails.application.routes.draw do
  root 'static_pages#home'
  get '/selection', to: 'static_pages#selection'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/join', to: 'joinings#new'
  post '/join', to: 'joinings#create'
  patch '/leave', to: 'joinings#update'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :hope_shifts
  resources :fixed_shifts do
    collection do
      get :day_index
    end
  end
  resources :groups, only: [:new, :create, :edit, :update]
end
