class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.nil?
      can :read, :all
    elsif user.has_role? :admin
      can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
    else
      can :manage, User, :id => user.id
      can :manage, Plot, :id => user.plots.pluck(:id)
      can :manage, Crop, :id => user.crops.pluck(:id)
      can :manage, CropYield, :id => user.crop_yields.pluck(:id)
    end

  end
end