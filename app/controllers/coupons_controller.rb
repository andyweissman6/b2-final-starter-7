class CouponsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index]

  def index
    @coupons = @merchant.coupons
  end

  def show
    # ...
  end

  def new
    @coupon = Coupon.new
  end

  def create
    coupon = Coupon.new( name: params[:name],
                        unique_code: params[:unique_code],
                        discount_type: params[:discount_type],
                          discount_amount: params[:discount_amount],
                          merchant: @merchant)
    if coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      flash[:alert] = "Form filled out incorrectly. Please try again."
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :unique_code, :discount_type, :discount_amount)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
    # redirect_to merchants_path, alert: "Merchant not found" unless @merchant
  end
end
