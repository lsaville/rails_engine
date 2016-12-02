require 'rails_helper'

describe Item, type: :model do
  before(:each) do
    @item = build(:item)
  end

  context 'relationships' do
    it 'belongs_to merchant' do
      expect(@item).to respond_to(:merchant)
    end

    it 'has_many invoice items' do
      expect(@item).to respond_to(:invoice_items)
    end

    it 'has_many invoices' do
      expect(@item).to respond_to(:invoices)
    end
  end

  context 'validations' do
    it 'is invalid without a name' do
      item = build(:item, name: nil)
      expect(item).to_not be_valid
    end

    it 'is invalid without a description' do
      item = build(:item, description: nil)
      expect(item).to_not be_valid
    end

    it 'is invalid without unit_price' do
      item = build(:item, unit_price: nil)
      expect(item).to_not be_valid
    end
  end
end
