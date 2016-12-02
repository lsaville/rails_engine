require 'rails_helper'

describe 'Transactions relationship endpoints' do
  context 'GET /:id/invoice' do
    it 'returns the associated invoice' do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice, status: 'super rad')
      transaction = create(:transaction, invoice: invoice2)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      response_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(response_invoice['status']).to eq('super rad')
    end
  end
end
