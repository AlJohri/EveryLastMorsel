class StaticController < ApplicationController
  def home
    @skip_footer = true
  end

  def map
    @skip_footer = true
  end
end