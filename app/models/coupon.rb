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

  def times_used
    self.invoices.joins(:transactions).where(transactions: { result: "success" }).count
    # self.invoices.joins(:transactions).where(transactions: { result: 1 }).count
    # self.invoices.joins(:transactions).where("transactions.result = 1").count
    # THESE ARE ALL DIFF WAYS TO WRITE SAME THING
  end
end