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

  context 'abilities' do
    it 'can return top x merchants by ranked by total number of items sold' do
      merchant1 = create(:merchant, name: 'Alejandra')
      merchant2 = create(:merchant, name: 'Billy')
      customer = create(:customer)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer)
      invoice2 = create(:invoice, merchant: merchant1, customer: customer)
      invoice3 = create(:invoice, merchant: merchant2, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 1)
      invoice_item2 = create(:invoice_item, invoice: invoice3, quantity: 1)
      create(:transaction, result: 'success', invoice: invoice1)
      create(:transaction, result: 'success', invoice: invoice2)

      result = Merchant.merchants_most_items(2)

      expect(result.first['name']).to eq(merchant1.name)
    end
  end
end
