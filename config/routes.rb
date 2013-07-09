EveryLastMorsel::Application.routes.draw do
  resources :users do
    resources :posts
  end

  # authenticated :user do
  #   root :to => 'home#home'
  # end

  root :to => "static#home"

  get '/about', controller: "static", action: "about", as: "about"
  get '/help', controller: "static", action: "help", as: "help"
  get '/map', controller: "static", action: "map", as: "map"
  get '/marketplace', controller: "static", action: "marketplace", as: "marketplace"
  get '/records', controller: "records", action: "index", as: "records"
  # get '/hub', controller: "hub", action: "index", as: "index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :crops, :plots
  resources :users, :path => '', :only => [:show]

end