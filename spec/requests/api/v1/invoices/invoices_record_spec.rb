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
 
      response_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(response_invoice['status']).to eq('suuuper')
    end
  end

  context 'GET /invoices/find?parameters' do
    it 'returns an invoice based on the string query params' do
      create_list(:invoice, 3)
      create(:invoice, status: 'fluffy')

      get '/api/v1/invoices/find?status=fluffy'

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['status']).to eq('fluffy')
    end
  end
end
