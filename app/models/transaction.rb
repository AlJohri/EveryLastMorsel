class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :amount, :crop_yield_id, :quantity
  
  validates :amount, presence: true
  validates :crop_yield_id, presence: true
  validates :quantity, presence: true
  
  belongs_to :crop_yield
  belongs_to :user
  
  # validations
  validates :quantity, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  
  def reduce_crop_yield_quantity
    crop_yield = self.crop_yield
    crop_yield.quantity_for_sale -= self.quantity
    crop_yield.save!
  end
  
  def get_amount(crop_yield)
    self.amount = crop_yield.price * self.quantity
  end
  
  def quantity_is_less_than?(crop_yield)
    if self.quantity < crop_yield.quantity
      true
    else
      false
    end
  end
  
  def send_to_braintree
    result = Braintree::Transaction.sale(
      :amount => self.amount.to_s,
      :merchant_account_id => "blue_ladders_store",
      :credit_card => {
        :number => "4111111111111111",
        :expiration_date => "12/12"
      },
      :options => {
        :submit_for_settlement => true,
        :hold_in_escrow => true
      },
      :service_fee_amount => "10.00"
    )
    result
  end
  
end
