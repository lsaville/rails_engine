require 'rails_helper'

describe 'Items business endpoints' do
  context 'GET /most_revenue?quantity=x' do
    it 'returns top x items ranked by total revenue generated' do
      item1 = create(:item)
      item2 = create(:item)
      invoice = create(:invoice)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice, quantity: 10)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, result: 'success')

      get '/api/v1/items/most_revenue?quantity=2'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(items.first['id']).to eq(item1.id)
    end
  end

  context 'GET /items/:id/best_day' do
    it 'returns date with most sales for a given item' do
      item1 = create(:item)
      item2 = create(:item)
      invoice = create(:invoice)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice, quantity: 10)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, result: 'success')

      get "/api/v1/items/#{item1.id}/best_day"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['best_day']).to eq(invoice.created_at.to_json)
    end
  end

  context 'GET /most_items?quantity=x' do
    it 'returns top x items ranked by total number sold' do
      item1 = create(:item)
      item2 = create(:item)
      invoice = create(:invoice)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice, quantity: 10)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, result: 'success')

      get '/api/v1/items/most_items?quantity=2'

      items_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(items_json.first['id']).to eq(item1.id)
    end
  end

end
