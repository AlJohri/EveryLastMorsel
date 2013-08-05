class ApplicationController < ActionController::Base
    before_filter :contextualize

    def contextualize
      if params[:plot_id]
        context = 'plots'
      elsif params[:user_id]
        context = 'users'
      else
        context = 'self'
      end

      # FIX THIS UGLY IF STATEMENT

      if (controller_name != "static" && controller_name != "registrations" && (!params[:controller].include? "rails_admin"))
        @context = "#{controller_name}/context/#{context}/#{action_name}"
      end
    end

    protect_from_forgery
    # after_filter :store_location

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to main_app.root_url, :alert => exception.message
    end

    def store_location
      # store last url as long as it isn't a /users path
      session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    # def not_found
    #   render file => "public/404.html", status => 404, layout => false
    # end

    # def after_sign_in_path_for(resource)
    #   session[:previous_url] || main_app.root_url
    # end

    # def after_update_path_for(resource)
    #   session[:previous_url] || main_app.root_url
    # end

    # def after_sign_out_path_for(resource)
    #   session[:previous_url] || main_app.root_url
    # end

    def xeditable?
      true # Or something like current_user.xeditable?
    end    

  private

  def render(*args)
    options = args.extract_options!
    options[:template] = @context if @context != nil
    super(*(args << options))
  end

end
