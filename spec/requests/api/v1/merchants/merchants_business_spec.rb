require 'rails_helper'

describe 'merchants business endpoints' do
  context 'GET /merchants/:id/customers_with_pending_invoices' do
    it 'returns a list of customers that have pending invoices' do
      customer1 = create(:customer, first_name: 'cliff')
      customer2 = create(:customer, first_name: 'samantha')
      merchant = create(:merchant, name: 'buzz')
      create(:invoice, merchant: merchant, customer: customer1, status: 'pending')
      create(:invoice, merchant: merchant, customer: customer2)

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"
      
      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(1)
    end
  end
end
