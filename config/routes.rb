EveryLastMorsel::Application.routes.draw do
  
  resources :transactions

  # webhooks for Braintree
  # get "/sub_merchant_acct_notification" => "merchant_accounts#bt_webhook_notification"
  get "/sub_merchant_acct_notification" do
    challenge = request.params["bt_challenge"]
    challenge_response = Braintree::WebhookNotification.verify(challenge)
    return [200, challenge_response]
  end

  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  ####################################################################################
  # STATIC ROUTES
  ####################################################################################

  ######## Home (no Auth), Home (with Auth), About, Help, Map, Marketplace ########
  authenticated :user do
    root :to => "activities#index", as: :authenticated_root
  end
  
  root :to => "static#home"
  scope :controller => "static" do
    get 'about'
    get 'help'
    get 'map'
    # get 'marketplace'
    get 'checkout'
    get 'confirm'
    get 'pricing' # TEMPORARY
  end

  ####################################################################################
  # ENGINE ROUTES
  ####################################################################################

  ############# Devise User ##################
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    :registrations => "devise/custom/registrations" 
  }

  ############## Rails Admin ##############
  # mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  ####################################################################################
  # CONCERNS
  ####################################################################################

  ############## Follow, Like, Comment ##############
  concern :is_followable do; get 'follow', :on => :member; end
  concern :is_likeable do; get 'like', :on => :member; end
  concern :is_commentable do; resources :comments, only: [:index, :create]; end

  ############## Posts, Plots, PlotCropVarieties ##############
  concern :has_posts do; resources :posts, concerns: [:is_likeable, :is_commentable]; end
  concern :has_plots do; resources :plots, concerns: [:is_followable]; end
  concern :has_crops do
    resources :crops do
      resources :crop_yields
    end
  end
  
  match "/marketplace", to: "crop_yields#marketplace", via: :get

  ####################################################################################
  # RESOURCES
  ####################################################################################

  ############## Users, Plots, Posts, Crops, Activies ##############
  resources :users, only: [], :path => '', concerns: [:is_followable, :has_posts, :has_crops, :has_plots] do
    resources :merchant_accounts, only: [:new, :create, :index]
  end
  
  # resources :users, only: [:index, :show], concerns: [:is_followable, :has_posts, :has_crops, :has_plots]
  resources :plots, only: [:index], concerns: [:is_followable, :has_crops]
  resources :posts, only: [:index, :show], concerns: [:is_likeable, :is_commentable]
  resources :crops, only: [:index, :show], controller: 'crop_types'
  resources :varieties, only: [:index, :show], controller: 'crop_varieties'
  resources :activites, only: [:index]
  resources :uploads # TEMPORARY

  get 'plots/:id' => redirect('/plots/%{id}/crops'), :as => 'plot'
  
  ####################################################################################
  # ALIASED ROUTES
  ####################################################################################

  ############## Blog, Feed ##############
  get '/blog' => "posts#index", :as => :blog
  get "/feed" => "activities#index", as: :feed

  ####################################################################################
  # API (V0)
  ####################################################################################

  scope "/api/v0/" do

    # devise_for :users, :controllers => { 
    #   :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    #   :registrations => "devise/custom/registrations" 
    # }

    # resources :users, only: [:index, :show], concerns: [:is_followable, :has_posts, :has_crops, :has_plots]
    resources :plots, only: [:index, :show], concerns: [:is_followable, :has_crops]
    resources :posts, only: [:index, :show], concerns: [:is_likeable, :is_commentable]
    resources :crops, only: [:index, :show], :controller => 'crop_types'
    resources :activites, only: [:index]    
  end

  ####################################################################################
  # VANITY URLS (must be last)
  ####################################################################################

  ############## User ##############
  get '/:id/message' => "conversations#message", as: "message_user"
  get '/:id(.:format)' => redirect('/%{id}/posts'), :as => :user
end

####### USER -> PLOTS/POSTS REGULAR ROUTES #######
# create regular routes under "/user" path for API
# routes should appear as
# /user/:user_id/plots/new
# /user/:posts_id/posts/new
# user CRUD can be done from this route
# CORRECT: /users/:user_id/new


# Notes
# http://ofps.oreilly.com/titles/9780596521424/routing.html
# "If multiple routes end up matching the same request, the one defined higher up in the file will be given priority."

# Links
# http://stackoverflow.com/questions/11570924/ruby-on-rails-how-to-override-the-show-route-of-a-resource
# http://stackoverflow.com/questions/10353776/rails-routing-override-the-action-name-in-a-resource-member-block
# https://github.com/rails/routing_concerns
# http://stackoverflow.com/questions/14632471/rails-routing-one-controller-one-model-with-type-multiple-routes
