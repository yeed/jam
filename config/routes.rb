Jamdancedaddymovemomma::Application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :videos
  root :to => 'home#index'

  get "home/single"
  get "home/initvideos"
  get "home/initvinevideos"
  get "home/whopass"
  post "home/whopass"
  post "home/index"

end
