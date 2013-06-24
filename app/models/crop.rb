class Crop < ActiveRecord::Base
  attr_accessible :coverage_number, :coverage_unit, :date_picked, :date_planted, :description, :plant, :plot_id, :price, :quantity_number, :quantity_type, :starting_type, :type, :yield_number, :yield_unit

  belongs_to :plot

end