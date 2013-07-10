# http://stackoverflow.com/questions/11570924/ruby-on-rails-how-to-override-the-show-route-of-a-resource
# http://stackoverflow.com/questions/10353776/rails-routing-override-the-action-name-in-a-resource-member-block
# https://github.com/rails/routing_concerns

# http://stackoverflow.com/questions/14632471/rails-routing-one-controller-one-model-with-type-multiple-routes

EveryLastMorsel::Application.routes.draw do

  # Static Routes
  root :to => "static#home"
  get '/about' => "static#about"
  get '/help' => "static#help"
  get '/map' => "static#map"
  get '/marketplace' => "static#marketplace"
  get '/records' => "records#index"

  scope module:'blogit' do 
    match "posts/page/:page" => "posts#index"
    match "posts/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
  end

  concern :postable do
    scope module:'blogit' do 
      get    '/posts(.:format)'               => 'custom/posts#index', :as => 'posts'
      post   '/posts(.:format)'               => 'custom/posts#create'
      get    '/posts/new(.:format)'           => 'custom/posts#new',  :as => 'new_post'
      get    '/posts/:post_id/edit(.:format)' => 'custom/posts#edit', :as => 'edit_post'
      get    '/posts/:post_id(.:format)'      => 'custom/posts#show', :as => 'post'
      put    '/posts/:post_id(.:format)'      => 'custom/posts#update'
      delete '/posts/:post_id(.:format)'      => 'custom/posts#destory'
      resources :comments, only: [:create, :destroy]
    end    
  end

  # Devise Routes for User Authentication
  # These must come before the other user routes
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "devise/custom/omniauth_callbacks",  
    :registrations => "devise/custom/registrations" 
  }

  # Nested Routes for User -> Plots and User -> Posts linked to "/users" URL.
  resources :users, concerns: :postable  do
    resources :plots, as: 'usfarm'
  end
  get 'users/:id/about' => 'users#about', :as => 'about'

  match  '/:user_id/posts/tagged/:tag'    => 'blogit/custom/posts#tagged', as: :tagged_blog_posts
  match  '/:user_id/posts/page/:page'     => "blogit/custom/posts#index"

  # Nested Routes for User -> Plots and User -> Posts linked to ROOT URL.
  get ':id/about' => 'users#about', :as => 'user_about'
  resources :users, :path => '', :only => [:show], concerns: :postable   do
    resources :plots
  end
end