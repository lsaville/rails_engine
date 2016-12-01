require 'rails_helper'

describe 'Invoice_items endpoints' do
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

  context 'GET /invoice_items/find?params' do
    it 'returns an invoice_item based on passed params' do
      create(:invoice_item, unit_price: 12345678)
      create(:invoice_item, unit_price: 0)

      get '/api/v1/invoice_items/find?unit_price=0'

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['unit_price']).to eq('0.0')
    end
  end

  context 'GET /invoice_items/find_all?params' do
    it 'returns all invoice_items based on params' do
      create_list(:invoice_item, 3, unit_price: 42354)
      create(:invoice_item)

      get '/api/v1/invoice_items/find_all?unit_price=423.54'

      invoices_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices_items.count).to eq(3)
    end
  end

  context 'GET /invoice_items/random' do
    it 'returns a random invoice_item' do
      create_list(:invoice_item, 10)
   
      get '/api/v1/invoice_items/random'

      invoice_item1 = JSON.parse(response.body)

      get '/api/v1/invoice_items/random'

      invoice_item2 = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item1['id']).to_not eq(invoice_item2['id'])
    end
  end
end
