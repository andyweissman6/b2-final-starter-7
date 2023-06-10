class RemoveInvoiceIdfromCoupons < ActiveRecord::Migration[7.0]
  def change
    remove_column :coupons, :invoice_id
  end
end
