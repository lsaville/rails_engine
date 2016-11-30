require 'rails_helper'

describe 'Invoice_tems endpoints' do
  context 'GET /invoice_items' do
    it 'returns a list of invoice items' do
      create_list(:invoice_item, 3)
      get '/api/v1/invoice_items'

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end

  context 'GET /invoice_items/:id' do
    it 'returns a specific invoice item' do
      invoice_item = create(:invoice_item, quantity: 80)
      get "/api/v1/invoice_items/#{invoice_item.id}"

      response_invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(response_invoice_item['quantity']).to eq(80)
    end
  end
end
