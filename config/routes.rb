EveryLastMorsel::Application.routes.draw do

  ######## ROOT/STATIC ROUTES ########
  authenticated :user do
    root :to => "posts#index"
  end
  root :to => "static#home"
  scope :controller => "static" do
    get 'about'
    get 'help'
    get 'map'
    get 'marketplace'
  end

  ############# DEVISE ##################
  # Devise Routes for User Authentication
  # Must come before any User routes
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    :registrations => "devise/custom/registrations" 
  }
  # devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }
  # devise_scope :user do
  #   get "sign_in", :to => "devise/sessions#new"
  # end

  ############# RAILS ADMIN ###############
  # devise_for :admins, :controllers => { 
  #   :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
  #   :registrations => "devise/custom/registrations" 
  # }  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :users, :path => '', only: [] do
    get 'about' => 'users#show', :on => :member
    get 'follow', :on => :member

    resources :plots do
      get 'follow', :on => :member
      get 'about' => 'plots#show', :on => :member
    end

    resources :posts do
      get 'like', :on => :member
      resources :comments
    end

  end

  resources :users, only: [:index, :show] do
    get 'about' => 'users#show', :on => :member
    get 'follow', :on => :member

    resources :plots do
      get 'follow', :on => :member
      get 'about' => 'plots#show', :on => :member
    end

    resources :posts do
      get 'like', :on => :member
      resources :comments
    end
  end

  resources :plots, only: [:index, :show] do
    get 'follow', :on => :member
    get 'about' => 'plots#show', :on => :member
    resources :crops, :controller => 'plot_crop_varieties'
  end
  
  resources :posts, only: [:index, :show] do
    get 'like', :on => :member
    resources :comments
  end

  resources :crops, only: [:index, :show]
  
  ############# USER VANITY URL ################
  get '/:id(.:format)' => 'users#show', :as => :user
end

  # ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  # Make sure this routeset is defined last
  # ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)


  ###### REGULAR ROUTES #######


  ###### USER -> PLOTS/POSTS VANITY ROUTES #######
  # path /:user_id so that paths are viewable as 
  # /:user_id/plots/new
  # /:user_id/posts/edit
  # etc.
  # user CRUD cannot be done from vanity URL
  # WRONG: /:user_id/new
  # resources :users, :path => '', except: [:index, :show, :new, :create, :edit, :destory, :update] do

  # scope :users, :path => '/:user_id', :as => "user" do


  ####### USER -> PLOTS/POSTS REGULAR ROUTES #######
  # create regular routes under "/user" path for API
  # routes should appear as
  # /user/:user_id/plots/new
  # /user/:posts_id/posts/new
  # user CRUD can be done from this route
  # CORRECT: /users/:user_id/new
  # scope "/api/v0/" do

    # devise_for :users, :controllers => { 
    #   :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    #   :registrations => "devise/custom/registrations" 
    # }

    # resources :users, except: [:show] do 
    # scope :users, :path => '/:user_id', :as => "user" do

      # resources :plots do
        # get 'follow', :on => :member
      # end

      # resources :posts do
        # get 'like', :on => :member
      # end

    # end
  # end

# Notes
# http://ofps.oreilly.com/titles/9780596521424/routing.html
# "If multiple routes end up matching the same request, the one defined higher up in the file will be given priority."

# Links
# http://stackoverflow.com/questions/11570924/ruby-on-rails-how-to-override-the-show-route-of-a-resource
# http://stackoverflow.com/questions/10353776/rails-routing-override-the-action-name-in-a-resource-member-block
# https://github.com/rails/routing_concerns
# http://stackoverflow.com/questions/14632471/rails-routing-one-controller-one-model-with-type-multiple-routes


############# UNSURE ###############
# Small Farm Book Keeping Tool?
# get '/records' => "records#index"
# match  '/:user_id/posts/tagged/:tag' => 'blogit/custom/posts#tagged', as: :tagged_blog_posts
# match  '/:user_id/posts/page/:page' => "blogit/custom/posts#index"  
####################################

# resources :uploads