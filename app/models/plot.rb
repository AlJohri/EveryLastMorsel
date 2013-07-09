class Plot < ActiveRecord::Base
  belongs_to :user
  attr_accessible :about, :city, :name, :state, :zip
end
