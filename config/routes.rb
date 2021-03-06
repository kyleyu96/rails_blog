Rails.application.routes.draw do

  root 'pages#home'

  resources :articles do
    resources :comments, only: [:create]
  end

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]

  mount ActionCable.server => '/cable'

end
