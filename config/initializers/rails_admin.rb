RailsAdmin.config do |config|

  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }
  # config.main_app_name = ['Every Last Morsel', 'Admin']
  config.current_user_method { current_user }
  config.authorize_with :cancan

end