class Plot < ActiveRecord::Base
  attr_accessible :city, :description, :name, :state, :type, :user_id, :visibility, :zip
  #admin_id taken out of attr_accessible
  
  has_many :crops
  

end
