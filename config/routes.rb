# http://stackoverflow.com/questions/11570924/ruby-on-rails-how-to-override-the-show-route-of-a-resource
# http://stackoverflow.com/questions/10353776/rails-routing-override-the-action-name-in-a-resource-member-block
# https://github.com/rails/routing_concerns

# http://stackoverflow.com/questions/14632471/rails-routing-one-controller-one-model-with-type-multiple-routes

EveryLastMorsel::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

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

  # Nested Routes for User -> Plots and User -> Posts linked to "/users" URL.
  resources :users  do
    resources :plots, as: 'usfarm'
  end
  get 'users/:id/about' => 'users#about', :as => 'about'

  # match  '/:user_id/posts/tagged/:tag'    => 'blogit/custom/posts#tagged', as: :tagged_blog_posts
  # match  '/:user_id/posts/page/:page'     => "blogit/custom/posts#index"

  # Nested Routes for User -> Plots and User -> Posts linked to ROOT URL.
  get ':id/about' => 'users#about', :as => 'user_about'
  resources :users, :path => '', :only => [:show] do
    resources :plots
  end
end