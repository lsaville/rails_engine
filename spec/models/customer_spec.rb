require 'rails_helper'

describe Customer, type: :model do
  before(:each) do
    @customer = build(:customer)
  end

  context 'relationships' do
    it 'has many invoices' do
      expect(@customer).to respond_to(:invoices)
    end

    it 'has many merchants' do
      expect(@customer).to respond_to(:merchants)
    end

    it 'has many transactions' do
      expect(@customer).to respond_to(:transactions)
    end
  end

  context 'validations' do
    it 'is invalid without a first name' do
      customer = build(:customer, first_name: nil)
      expect(customer).to_not be_valid
    end

    it 'is invalid without a last name' do
      customer = build(:customer, last_name: nil)
      expect(customer).to_not be_valid
    end
  end
end
