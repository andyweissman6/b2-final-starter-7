class Coupon < ApplicationRecord
    belongs_to :merchant
    has_many :invoices
    
    enum status: [:activated, :deactivated]
    enum discount_type: [:dollar_off, :percent_off]
end