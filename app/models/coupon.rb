class Coupon < ApplicationRecord
    belongs_to :merchant
    has_many :invoices
    
    enum status: [:deactivated, :activated]
    enum discount_type: [:dollar_off, :percent_off]
end