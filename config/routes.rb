EveryLastMorsel::Application.routes.draw do
  
  # authenticated :user do
  #   root :to => 'home#home'
  # end

  root :to => "static#home"

  mount Blogit::Engine => "/blog"
  get '/about', controller: "static", action: "about", as: "about"
  get '/help', controller: "static", action: "help", as: "help"
  get '/map', controller: "static", action: "map", as: "map"
  get '/marketplace', controller: "static", action: "marketplace", as: "marketplace"
  get '/records', controller: "records", action: "index", as: "records"


  mount Blogit::Engine => "/blog"

  # The devise controller must be before the users resource
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",  :registrations => "devise/custom/registrations" }
  resources :users

  # This must be the last route
  resources :users, :path => '', :only => [:show]
end
