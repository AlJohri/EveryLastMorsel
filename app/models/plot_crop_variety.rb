class PlotCropVariety < ActiveRecord::Base
  attr_accessible :coverage, :coverage_type, :plant_date, :crop_name
  attr_accessible :plot_id, :crop_id, :variety_id
  belongs_to :plot
  belongs_to :crop
  belongs_to :variety

  has_many :yields

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  def crop_name

  end

  def crop_name=(crop_name)
    self.crop_name = Crop.find_by_name(name) if name.present?
  end


end