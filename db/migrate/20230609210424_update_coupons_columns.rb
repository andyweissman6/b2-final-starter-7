class UpdateCouponsColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :coupons, :percent_off
    remove_column :coupons, :dollar_off
    add_column :coupons, :discount_type, :integer
    add_column :coupons, :discount_amount, :decimal
  end
end
