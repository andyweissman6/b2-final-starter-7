class RemoveMerchantFromInvoices < ActiveRecord::Migration[7.0]
  def change
    remove_column :invoices, :merchant_id
    

  end
end
