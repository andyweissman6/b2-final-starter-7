class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @coupon = 
  end
end
