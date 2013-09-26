class MerchantAccount < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :street_address, :postal_code,
                  :locality, :region, :date_of_birth, :ssn, :routing_number, :account_number,
                  :tos_accepted
                  
  # associations
  belongs_to :user
  
  # validations
  validates :first_name, :last_name, :email, :street_address, :postal_code,
            :locality, :region, :date_of_birth, :tos_accepted, 
            presence: true
  
end
