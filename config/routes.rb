EveryLastMorsel::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  #match "/about" => "about#index"
  #match "/help" => "help#index"
  #mount Blogit::Engine => "/blog"
end