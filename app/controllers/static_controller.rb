class StaticController < ApplicationController
  def index
    @users = User.all
  end

  def map
    @skip_footer = true
  end
end