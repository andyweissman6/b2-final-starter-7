require "rails_helper"

RSpec.describe "Coupon Show" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Tom's Trinkets")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    @coupon1 = Coupon.create!(name: "Last Season", unique_code: "LS10", discount_type: 0, discount_amount: 10, merchant_id: @merchant1.id)
    @coupon2 = Coupon.create!(name: "Black Friday", unique_code: "BF2023", discount_type: 0, discount_amount: 20, merchant_id: @merchant1.id)
    @coupon3 = Coupon.create!(name: "Cyber Monday", unique_code: "CYBER", discount_type: 0, discount_amount: 30, merchant_id: @merchant1.id)
    @coupon4 = Coupon.create!(name: "Summer Savings", unique_code: "SUMMER23", discount_type: 1, discount_amount: 0.23, merchant_id: @merchant1.id)
    @coupon5 = Coupon.create!(name: "End of Year Sale", unique_code: "NEWYEAR24", discount_type: 1, discount_amount: 0.15, merchant_id: @merchant1.id)
    @coupon6 = Coupon.create!(name: "Liquidation Sale", unique_code: "EVERYTHING", discount_type: 1, discount_amount: 0.5, merchant_id: @merchant2.id)
  end

  it "displays each coupon name, unique code, percent/dollar off, and times used" do
    @invoice_1.update(coupon_id: @coupon1.id)

    visit merchant_coupon_path(@merchant1, @coupon1)
    within("#coupon-info") do
      expect(page).to have_content("name: Last Season")
      expect(page).to have_content("unique code: LS10")
      expect(page).to have_content("discount amount: 10")
      expect(page).to have_content("status: deactivated")
      expect(page).to have_content("times used: 1")

    end
  end

  it "displays button to deactivate the coupon" do
    @invoice_1.update(coupon_id: @coupon1.id)
    @coupon1.update(status: 1)
    expect(@coupon1.status).to eq("activated")
    visit merchant_coupon_path(@merchant1, @coupon1)

    within("#deactivate") do
      expect(page).to have_button("deactivate coupon")

      click_button("deactivate coupon")
      @coupon1.reload

      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
      expect(@coupon1.status).to eq("deactivated")
    end
  end

  it "displays button to activate the coupon" do
    @invoice_1.update(coupon_id: @coupon1.id)
    expect(@coupon1.status).to eq("deactivated")

    visit merchant_coupon_path(@merchant1, @coupon1)
    within("#activate") do
      expect(page).to have_button("activate coupon")

      click_button("activate coupon")
      @coupon1.reload

      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
      expect(@coupon1.status).to eq("activated")
    end
  end
end

