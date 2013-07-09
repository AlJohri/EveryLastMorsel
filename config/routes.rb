EveryLastMorsel::Application.routes.draw do

  # Static Routes
  root :to => "static#home"
  get '/about' => "static#about"
  get '/help' => "static#help"
  get '/map' => "static#map"
  get '/marketplace' => "static#marketplace"
  get '/records' => "records#index"

  # Devise Routes for User Authentication
  # These must come before the other user routes
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    :registrations => "devise/custom/registrations" 
  }

  # Nested Routes for User -> Plots and User -> Posts
  resources :users do
    resources :plots

    ######## BlOG ROUTE #########
    scope module:'blogit' do 
      resources :posts do
          resources :comments, only: [:create, :destroy]
      end
    end
    ###### END BLOG ROUTE ######

  end

  # Route to enable URLS 
  resources :users, :path => '', :only => [:show] do
    resources :plots

    ######## BlOG ROUTE #########
    scope module:'blogit' do 
      resources :posts do
          resources :comments, only: [:create, :destroy]
      end
    end
    ###### END BLOG ROUTE ######

  end

end

# authenticated :user do
#   root :to => 'home#home'
# end

# get ':controller(/:action(/:id))'
# get ':controller(/:action(/:id)(.:format))'

# mount Blogit::Engine => "/feed"

# match "posts/page/:page" => "posts#index"
# match "posts/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts

# concerns
# http://guides.rubyonrails.org/routing.html


# scope module:'blogit' do 
#   resources :posts, :only => [:new, :create, :edit, :update] 
# end