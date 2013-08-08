class Crop < ActiveRecord::Base
  belongs_to :plot
  belongs_to :crop_type
  belongs_to :crop_variety
  attr_accessible :plot_id, :crop_type_id, :crop_variety_id
  attr_accessible :coverage, :coverage_unit, :plant_date

  attr_accessible :crop_name

  has_many :crop_yields

  validates :plot_id, presence: true
  validates :crop_type_id, presence: true
  validates :crop_variety_id, presence: true

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  def crop_name
    self.crop_type.try(:name)
  end

  def crop_name=(name)
    self.crop_type = CropType.find_by_name(name) if name.present?
  end
  
end
