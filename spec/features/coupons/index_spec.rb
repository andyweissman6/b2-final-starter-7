require "rails_helper"

RSpec.describe "Coupon index" do
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
    @coupon5 = Coupon.create!(name: "End of Year Sale", unique_code: "NEWYEAR24", discount_type: 1, discount_amount: 0.15, merchant_id: @merchant1.id, status: 1)
    @coupon6 = Coupon.create!(name: "Liquidation Sale", unique_code: "EVERYTHING", discount_type: 1, discount_amount: 0.5, merchant_id: @merchant2.id, status: 1)
  end
  
  it "displays all coupon names and the discount amount" do
    visit merchant_coupons_path(@merchant1)
    expect(page).to have_content("coupon name: #{@coupon1.name}")
    expect(page).to have_content("discount amount: #{@coupon1.discount_amount}")
    expect(page).to have_content("coupon name: #{@coupon2.name}")
    expect(page).to have_content("discount amount: #{@coupon2.discount_amount}")
    expect(page).to have_content("coupon name: #{@coupon3.name}")
    expect(page).to have_content("discount amount: #{@coupon3.discount_amount}")
    expect(page).to have_content("coupon name: #{@coupon4.name}")
    expect(page).to have_content("discount amount: #{@coupon4.discount_amount}")
    expect(page).to have_content("coupon name: #{@coupon5.name}")
    expect(page).to have_content("discount amount: #{@coupon5.discount_amount}")
    expect(page).to_not have_content("coupon name: #{@coupon6.name}")
    expect(page).to_not have_content("discount amount: #{@coupon6.discount_amount}")
  end

  it "displays each name as a link to its show page" do
    visit merchant_coupons_path(@merchant1)
    expect(page).to have_link("#{@coupon1.name}")
    click_link("#{@coupon1.name}")
    expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
  end

  #User Story 2: Merchant Coupons Create
  it "displays a link to create a new coupon; link goes to new page form" do
    visit merchant_coupons_path(@merchant1)
    expect(page).to have_link("Create New Coupon")
    click_link("Create New Coupon")
    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
  end

  it "can fill in that form with a name, unique code, an amount, 
      percent/dollar amount; 
      redirects to coupon index page after submitted" do
    visit merchant_coupons_path(@merchant1)
    click_link("Create New Coupon")
    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
    fill_in "Name", with: "Grand Opening"
    fill_in "Unique Code", with: "WELCOME"
    select "dollar_off", from: "discount_type"
    fill_in "Discount Amount", with: "8"
    click_button "Create Coupon"
      
    expect(current_path).to eq(merchant_coupons_path(@merchant1))
    expect(page).to have_content("coupon name: Grand Opening")
    expect(page).to have_content("unique code: WELCOME")
    expect(page).to have_content("discount type: dollar_off")
    expect(page).to have_content("discount amount: 8")
    expect(page).to have_content("status: deactivated")
  end

  it "will not allow a new active coupon to be created if maximum active coupons limit is reached" do
    @coupon1.update(status: 1)
    @coupon2.update(status: 1)
    @coupon3.update(status: 1)
    @coupon4.update(status: 1)
    @coupon5.update(status: 1)

    visit merchant_coupons_path(@merchant1)
    click_link("Create New Coupon")
    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
    fill_in "Name", with: "Grand Opening"
    fill_in "Unique Code", with: "WELCOME"
    select "dollar_off", from: "discount_type"
    fill_in "Discount Amount", with: "8"
    select "activated", from: "status"
    click_button "Create Coupon"
    
    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
    expect(page).to have_content("Error: 5 coupons are already active. Please deactivate this coupon before clicking 'Create Coupon'.")
  end

  it "displays active coupons in its own section" do
    visit merchant_coupons_path(@merchant1)
    within("#activated-coupons") do
      expect(page).to have_content("coupon name: #{@coupon5.name}")
      expect(page).to_not have_content("coupon name: #{@coupon1.name}")
      expect(page).to_not have_button("activate coupon")
    end
  end

  it "displays active coupons in its own section" do
    visit merchant_coupons_path(@merchant1)
    within("#deactivated-coupons") do
      expect(page).to have_content("coupon name: #{@coupon1.name}")
      expect(page).to have_content("coupon name: #{@coupon2.name}")
      expect(page).to have_content("coupon name: #{@coupon3.name}")
      expect(page).to have_content("coupon name: #{@coupon4.name}")
      expect(page).to_not have_content("coupon name: #{@coupon5.name}")
      expect(page).to_not have_button("deactivate coupon")
    end
  end
end