EveryLastMorsel::Application.routes.draw do

  # authenticated :user do
  #   root :to => 'home#home'
  # end

  root :to => "static#home"

  # get '/about', controller: "static", action: "about", as: "about"
  # get '/help', controller: "static", action: "help", as: "help"
  # get '/map', controller: "static", action: "map", as: "map"
  # get '/marketplace', controller: "static", action: "marketplace", as: "marketplace"
  # get '/records', controller: "records", action: "index", as: "records"

  # mount Blogit::Engine => "/feed"

  # The devise controller must be before the users resource

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    :registrations => "devise/custom/registrations" 
  }

  # :omniauth_callbacks => "users/omniauth_callbacks",  
  resources :users do
    resources :plots
    scope module:'blogit' do 
      resources :posts do
          resources :comments, only: [:create, :destroy]
      end
    end
  end

  # This must be the last named route
  # resources :users, :path => '', :only => [:show] do
  #   resources :plots
  # end

  get ':controller(/:action(/:id))'
  get ':controller(/:action(/:id)(.:format))'

end

# match "posts/page/:page" => "posts#index"
# match "posts/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts

# concerns
# http://guides.rubyonrails.org/routing.html


# scope module:'blogit' do 
#   resources :posts, :only => [:new, :create, :edit, :update] 
# end