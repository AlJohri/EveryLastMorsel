class CropYield < ActiveRecord::Base
  attr_accessible :crop_id, :user_id
  attr_accessible :pick_date, :quantity, :quantity_for_sale, :quantity_unit, :price
  
  # associations
  belongs_to :crop
  belongs_to :user
  
  # validations
  validates :user_id, presence: true
  validates :quantity, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity_for_sale, :numericality => { only_integer: true }
  validate :merchant_account_active
  
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }  
  
  scope :for_sale, ->() { where("quantity_for_sale > ?", 0) }
  
  def merchant_account_active
    if quantity_for_sale > 0
      unless self.user.merchant_account.present? && self.user.merchant_account.status == "active"
        errors.add(:quantity_for_sale, "can only be added if you have an active merchant account")
      end
    end
  end
  
  def for_sale?
    self.quantity_for_sale > 0 ? true : false
  end
  
  def farmers
    self.crop.plot.users.pluck(:name).to_sentence
  end
end
