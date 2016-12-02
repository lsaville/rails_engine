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

  context 'GET /invoices/find_all?params' do
    it 'returns all invoices matching the params' do
      create_list(:invoice, 2, status: 'comatose')
      create_list(:invoice, 3)

      get '/api/v1/invoices/find_all?status=comatose'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
    end
  end

  context 'GET /invoices/random' do
    it 'returns a random invoice' do
      create_list(:invoice, 50)

      get '/api/v1/invoices/random'

      invoice1 = JSON.parse(response.body)

      get '/api/v1/invoices/random'

      invoice2 = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice1['id']).to_not eq(invoice2['id'])
    end
  end
end
