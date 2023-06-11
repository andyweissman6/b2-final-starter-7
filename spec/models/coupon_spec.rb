require 'rails_helper'

RSpec.describe Coupon, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @coupon_example1 = @merchant1.coupons.create!(name: "TEST1", unique_code: "CODE1", discount_type: 0, discount_amount: 0)
    @coupon2_example2 = @merchant1.coupons.new(name: "TEST2", unique_code: "CODE2", discount_type: 0, discount_amount: 0)
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :unique_code }
    it { should validate_uniqueness_of(:unique_code).case_insensitive }
    # it { should validate validate_presence_of :discount_type }
    # it { should validate validate_presence_of :discount_amount }
  end
  
  # it "validates case-sensitive uniqueness of unique_code" do
    
  #   expect(@coupon2.valid?).to be_falsey
  #   expect(@coupon2.errors[:unique_code]).to include("has already been taken")
  # end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end

  
end