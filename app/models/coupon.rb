class Coupon < ApplicationRecord
  validates_presence_of :name, 
                        :unique_code,
                        :discount_type,
                        :discount_amount

  validates :unique_code, uniqueness: true

    belongs_to :merchant
    has_many :invoices
    
    enum status: [:deactivated, :activated]
    enum discount_type: [:dollar_off, :percent_off]


end