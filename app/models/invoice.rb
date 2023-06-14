class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  belongs_to :coupon, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total_revenue
    if coupon.discount_type == "dollar_off" && coupon.discount_amount < total_revenue
      total_revenue - coupon.discount_amount 
    elsif coupon.discount_type == "percent_off" # percent-off
      total_revenue - (total_revenue * (coupon.discount_amount / 100.0))
    else coupon.discount_type == "dollar_off" && coupon.discount_amount > total_revenue
      return 0
    end
  end
  
  
end
