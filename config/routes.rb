EveryLastMorsel::Application.routes.draw do
  resources :crops


  resources :plots


  resources :posts
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users

  get "/about", controller: "home", action: "about", as: "about"
  get '/help', controller: "home", action: "help", as: "help"

  #mount Blogit::Engine => "/blog"
end