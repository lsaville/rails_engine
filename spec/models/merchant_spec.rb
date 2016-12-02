require 'rails_helper'

describe Merchant, type: :model do
  before(:each) do
    @merchant = build(:merchant)
  end

  context 'relationships' do
    it 'has many invoices' do
      expect(@merchant).to respond_to(:invoices)
    end

    it 'has many items' do
      expect(@merchant).to respond_to(:items)
    end

    it 'has many customers' do
      expect(@merchant).to respond_to(:customers)
    end

    it 'has many invoice items' do
      expect(@merchant).to respond_to(:invoice_items)
    end

    it 'has many transactions' do
      expect(@merchant).to respond_to(:transactions)
    end
  end

  context 'validations' do
    it 'is invalid without a name' do
      merchant = build(:merchant, name: nil)
      expect(merchant).to_not be_valid
    end
  end
end
