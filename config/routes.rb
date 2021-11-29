Rails.application.routes.draw do
  root 'static_pages#home'
  get '/selection', to: 'static_pages#selection'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/join', to: 'joinings#new'
  get '/destroy_confirm', to: 'joinings#confirm'
  post '/join', to: 'joinings#create'
  patch '/leave', to: 'joinings#update'
  delete '/destroy_confirm', to: 'joinings#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :hope_shifts
  resources :fixed_shifts do
    collection do
      get :day_index
      post :line_notify
    end
  end
  resources :groups, only: [:new, :create, :edit, :update]
end
