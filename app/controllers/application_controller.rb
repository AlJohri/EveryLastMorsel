class ApplicationController < ActionController::Base
  after_filter :store_location
  include ActionView::Helpers::TextHelper
  include PublicActivity::StoreController

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_url, :alert => exception.message
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
    # render file => "public/404.html", status => 404, layout => false
  end

  def store_location
    if (request.fullpath != "/users/sign_in" && request.fullpath != "/users/sign_up" && !request.xhr?)
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    user_url(resource)
    # session[:previous_url] || main_app.root_url
  end

  def after_update_path_for(resource)
    session[:previous_url] || main_app.root_url
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || main_app.root_url
  end

  def xeditable?
    true # Or something like current_user.xeditable?
  end

  def render(*args)


    # Check if controller inherits from InheritedResources::Base
    # If so, change view route to prepend "context/#{context}"
    # to serve the correct view.
    
    #&& (request.format == "text/html") # && (!request.xhr?)
    #context = parent? ? parent_class.to_s.downcase.pluralize : "self" # parent_type.to_s.downcase.pluralize    

    options = args.extract_options!
    
    if (self.class.ancestors.include? InheritedResources::Base)
      action = options[:action] || action_name
      context = parent? ? parent_type.to_s.downcase.pluralize : "self"
      path = "#{controller_name}/#{context}/#{action}"
    end

    options[:template] = path if context != nil
    super(*(args << options))
  end

end
