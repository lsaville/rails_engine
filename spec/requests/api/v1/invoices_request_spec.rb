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
end
