require 'rails_helper'

describe 'Invoices endpoints' do
  context 'GET /invoices' do
    it 'returns a list of all invoices' do
      create_list(:invoice, 3)
      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)
	      
      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end

  context 'GET /invoices/:id' do
    it 'returns an invoice' do
      invoice = create(:invoice, status: 'suuuper')
      get "/api/v1/invoices/#{invoice.id}"

      expect(response).to be_success
      expect(invoice.status).to eq('suuuper')
    end
  end
end
