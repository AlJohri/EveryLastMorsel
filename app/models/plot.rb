class Plot < ActiveRecord::Base
  attr_accessible :user_id
  attr_accessible :about, :city, :name, :state, :zip
  attr_accessible :plot_crop_variety_ids
  acts_as_followable

  belongs_to :user
  has_many :plot_crop_varieties
  has_many :crops, :through => :plot_crop_varieties
  has_many :varieties, :through => :plot_crop_varieties
end