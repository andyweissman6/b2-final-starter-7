class AddInvoiceIdToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_reference :coupons, :invoice, null: false, foreign_key: true
  end
end
