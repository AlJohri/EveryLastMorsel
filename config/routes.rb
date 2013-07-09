EveryLastMorsel::Application.routes.draw do

  # authenticated :user do
  #   root :to => 'home#home'
  # end

  root :to => "static#home"

  get '/about', controller: "static", action: "about", as: "about"
  get '/help', controller: "static", action: "help", as: "help"
  get '/map', controller: "static", action: "map", as: "map"
  get '/marketplace', controller: "static", action: "marketplace", as: "marketplace"
  get '/records', controller: "records", action: "index", as: "records"

  # mount Blogit::Engine => "/feed"

  scope module:'blogit' do 
    # match "feed/page/:page" => "posts#index"
    match "feed/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts
    resources :feed, controller: 'posts', :only => [:index, :show] do
        resources :comments, only: [:create, :destroy]
    end
  end

  # The devise controller must be before the users resource
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",  :registrations => "devise/custom/registrations" }
  resources :users do
    scope module:'blogit' do 
      resources :posts, :only => [:new, :edit] 
    end
    resources :plots
  end

  # This must be the last route
  resources :users, :path => '', :only => [:show] do
    scope module:'blogit' do 
      resources :posts, :only => [:new, :edit] 
    end
    resources :plots
  end

end