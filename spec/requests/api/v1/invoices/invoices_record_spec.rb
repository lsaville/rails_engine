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
    it 'returns an invoice based on a parameter' do
      create(:invoice, status: 'slow')
      create(:invoice, status: 'fast')

      get '/api/v1/invoices/find?status=slow'

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['status']).to eq('slow')
    end
  end

  context 'GET /invoices/find_all?parameters' do
    it 'returns a set of matching invoices' do
      create_list(:invoice, 3, status: 'incredible')
      create(:invoice)

      get '/api/v1/invoices/find_all?status=iNcrEDible'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
end
