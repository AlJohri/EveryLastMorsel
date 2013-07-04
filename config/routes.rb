EveryLastMorsel::Application.routes.draw do
  # authenticated :user do
  #   root :to => 'home#index'
  # end

  root :to => "static#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :crops, :plots, :posts
  resources :users, :path => '', :only => [:show]
  

  get "/about", controller: "static", action: "about", as: "about"
  get '/help', controller: "static", action: "help", as: "help"
  get '/records', controller: "records", action: "index", as: "records"

end