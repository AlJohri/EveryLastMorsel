EveryLastMorsel::Application.routes.draw do
  
  resources :uploads


  ######## ROOT/STATIC ROUTES ########
  root :to => "static#home"
  scope :controller => "static" do
    get 'about'
    get 'help'
    get 'map'
    get 'marketplace'    
  end
  
  ############# UNSURE ###############
  # Small Farm Book Keeping Tool?
  # get '/records' => "records#index"
  # match  '/:user_id/posts/tagged/:tag' => 'blogit/custom/posts#tagged', as: :tagged_blog_posts
  # match  '/:user_id/posts/page/:page' => "blogit/custom/posts#index"  
  ####################################
  
  ############# RAILS ADMIN ###############
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'  

  ############# DEVISE ##################
  # Devise Routes for User Authentication
  # Must come before any User routes
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    :registrations => "devise/custom/registrations" 
  }
  
  ###### PLOTS/POSTS REGULAR ROUTES #######
  resources :plots, :posts, only: [:index, :show]

  ###### USER -> PLOTS/POSTS VANITY ROUTES #######
  # path /:user_id so that paths are viewable as 
  # /:user_id/plots/new
  # /:user_id/posts/edit
  # etc.
  # user CRUD cannot be done from vanity URL
  # WRONG: /:user_id/new
  # MAKE THIS ROUTE LOOK NICER LATER
  resources :users, :path => '', except: [:index, :show, :new, :create, :edit, :destory, :update] do
  # scope :users, :path => '/:user_id' do
    resources :plots, :posts
  end
  get '/:user_id/about' => 'users#show', :as => :user_about

  ####### USER -> PLOTS/POSTS REGULAR ROUTES #######
  # create regular routes under "/user" path for API
  # routes should appear as
  # /user/:user_id/plots/new
  # /user/:posts_id/posts/new
  # user CRUD can be done from this route
  # CORRECT: /users/:user_id/new
  resources :users, except: [:show] do 
    resources :plots, :posts
  end
  
  ############# USER VANITY URL ################
  get '/:user_id(.:format)' => 'users#show', :as => :user
end

# Notes
# http://ofps.oreilly.com/titles/9780596521424/routing.html
# "If multiple routes end up matching the same request, the one defined higher up in the file will be given priority."

# Links
# http://stackoverflow.com/questions/11570924/ruby-on-rails-how-to-override-the-show-route-of-a-resource
# http://stackoverflow.com/questions/10353776/rails-routing-override-the-action-name-in-a-resource-member-block
# https://github.com/rails/routing_concerns
# http://stackoverflow.com/questions/14632471/rails-routing-one-controller-one-model-with-type-multiple-routes