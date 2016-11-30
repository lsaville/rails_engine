require 'rails_helper'

describe 'Customer business endpoints' do
  context 'GET :id/invoices' do
    it 'returns a collection of associated invoices' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      create_list(:invoice, 3, customer: customer1)
      create(:invoice, customer: customer2)

      get "/api/v1/customers/#{customer1.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
end
