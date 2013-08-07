class ApplicationController < ActionController::Base
  after_filter :store_location
  include ActionView::Helpers::TextHelper

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
    session[:previous_url] || main_app.root_url #root_path
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

  private

  def namespaced_controller_name
    return controller_path.gsub(/\//, '::').gsub(/\b\w/){ $&.upcase }
  end

  def render(*args)

    begin
      
      controller = (namespaced_controller_name + "Controller").constantize

      # Check if controller inherits from InheritedResources::Base
      if controller.respond_to?('parent')
        if parent?
          context = parent_class.to_s.pluralize
        else
          context = "self"
        end

        path = "#{controller_name}/context/#{context}/#{action_name}"
      end

    rescue => e
       puts e.message
    end

    options = args.extract_options!
    options[:template] = path if context != nil
    super(*(args << options))
  end

end
