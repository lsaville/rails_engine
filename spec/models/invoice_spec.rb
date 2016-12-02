require 'rails_helper'

describe :invoice, type: :model do
  before(:each) do
    @invoice = build(:invoice)
  end

  context 'relationships' do
    it 'belongs to a customer' do
      expect(@invoice).to respond_to(:customer)
    end

    it 'belongs to a merchant' do
      expect(@invoice).to respond_to(:merchant)
    end

    it 'has many transactions' do
      expect(@invoice).to respond_to(:invoice_items)
    end

    it 'has many items' do
      expect(@invoice).to respond_to(:items)
    end

    it 'has many invoice_items' do
      expect(@invoice).to respond_to(:invoice_items)
    end
  end

  context 'validations' do
    it 'is invalid without a status' do
      invoice = build(:invoice, status: nil)
      expect(invoice).to_not be_valid
    end
  end
end
