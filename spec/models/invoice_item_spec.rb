require 'rails_helper'

describe InvoiceItem, type: :model do
  before(:each) do
    @invoice_item = build(:invoice_item)
  end

  context 'relationships' do
    it 'belongs to an item' do
      expect(@invoice_item).to respond_to(:item)
    end

    it 'belongs to an invoice' do
      expect(@invoice_item).to respond_to(:invoice)
    end
  end

  context 'validations' do
    it 'is invalid without quantity' do
      invoice_item = build(:invoice_item, quantity: nil)
      expect(invoice_item).to_not be_valid
    end

    it 'is invalid without unit price' do
      invoice_item = build(:invoice_item, unit_price: nil)
      expect(invoice_item).to_not be_valid
    end
  end
end
