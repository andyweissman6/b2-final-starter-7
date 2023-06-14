class CouponsController < ApplicationController
  before_action :find_merchant, only: [:new, :show, :create, :index]

  def index
    @coupons = @merchant.coupons
    @holidays = HolidayBuilder.get_next_holidays
  end

  def show
    @coupon = Coupon.find(params[:id])
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
    if @merchant.active_maximum?
      redirect_to new_merchant_coupon_path
      flash[:alert] = "Error: 5 coupons are already active. Please deactivate this coupon before clicking 'Create Coupon'."
    elsif coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      redirect_to new_merchant_coupon_path
      flash[:alert] = "Form filled out incorrectly. Please try again."
    end
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    coupon = Coupon.find(params[:id])
    coupon.update(update_coupon_params)
    redirect_to merchant_coupon_path(merchant, coupon)
    flash[:notice] = "Coupon status updated successfully"
  end
  

  private

  def update_coupon_params
    params.permit(:status)
  end


  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
