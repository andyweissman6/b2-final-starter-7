# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke
# Transaction.destroy_all
# InvoiceItem.destroy_all
# Item.destroy_all
# Invoice.destroy_all
# Merchant.destroy_all
# Customer.destroy_all

@merchant1 = Merchant.create!(name: "Hair Care")
@merchant2 = Merchant.create!(name: "Tom's Trinkets")
@coupon1 = Coupon.create!(name: "Last Season", unique_code: "LS10", discount_type: 0, discount_amount: 10, merchant_id: @merchant1.id)
@coupon2 = Coupon.create!(name: "Black Friday", unique_code: "BF2023", discount_type: 0, discount_amount: 20, merchant_id: @merchant1.id)
@coupon3 = Coupon.create!(name: "Cyber Monday", unique_code: "CYBER", discount_type: 0, discount_amount: 30, merchant_id: @merchant1.id)
@coupon4 = Coupon.create!(name: "Summer Savings", unique_code: "SUMMER23", discount_type: 1, discount_amount: 0.23, merchant_id: @merchant1.id)
@coupon5 = Coupon.create!(name: "End of Year Sale", unique_code: "NEWYEAR24", discount_type: 1, discount_amount: 0.15, merchant_id: @merchant1.id)
@coupon6 = Coupon.create!(name: "Liquidation Sale", unique_code: "EVERYTHING", discount_type: 1, discount_amount: 0.5, merchant_id: @merchant2.id)