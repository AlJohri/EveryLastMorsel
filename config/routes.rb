EveryLastMorsel::Application.routes.draw do
  resources :posts
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  match "/about" => "home#about"
  match "/help" => "home#help"
  #mount Blogit::Engine => "/blog"
end