module ApplicationHelper

  def devise_resource_name
    :user
  end

  def devise_resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end