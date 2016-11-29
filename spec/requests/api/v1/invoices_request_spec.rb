require 'rails_helper'

describe 'Invoices endpoints' do
  context 'GET /invoices' do
    it 'returns a list of all invoices' do
      create_list(:invoice, 3)
      get '/api/v1/invoices'

      items = JSON.parse(response.body)
	      
      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end

  context 'GET /invoices/:id' do
    it 'returns an invoice' do
      item = create(:invoice, status: 'suuuper')
      get "/api/v1/invoices/#{item.id}"

      expect(response).to be_success
      expect(item.status).to eq('suuuper')
    end
  end
end
