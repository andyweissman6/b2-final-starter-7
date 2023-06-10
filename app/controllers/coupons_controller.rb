class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id]) #find this specific id
    @coupons = @merchant.coupons #find all coupons
  end

  def show  
  end
end