require 'rails_helper'

describe Transaction, type: :model do
  before(:each) do
    @transaction = build(:transaction)
  end

  context 'relationships' do
    it 'belongs to an invoice' do
      expect(@transaction).to respond_to(:invoice)
    end
  end

  context 'validations' do
    it 'is invalid without a credit card number' do
      transaction = build(:transaction, credit_card_number: nil)
      expect(transaction).to_not be_valid
    end

    it 'is invalid without a result' do
      transaction = build(:transaction, result: nil)
      expect(transaction).to_not be_valid
    end
  end
end
