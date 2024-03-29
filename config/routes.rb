Rails.application.routes.draw do
  resources :beerclubs
  resources :users
  resources :beers
  resources :breweries
  resources :styles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'breweries#index'

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  post 'places', to: 'places#search'


  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :memberships, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
end
