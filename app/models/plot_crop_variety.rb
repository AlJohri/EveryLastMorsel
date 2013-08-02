class PlotCropVariety < ActiveRecord::Base
  attr_accessible :coverage, :coverage_type, :plant_date
  attr_accessible :plot_id, :crop_id, :variety_id
  belongs_to :plot
  belongs_to :crop
  belongs_to :variety

  has_many :yields
end