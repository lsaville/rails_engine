require 'rails_helper'

describe 'Item Relationship Endpoints' do
  context 'GET /items/:id/invoice_items' do
    it 'returns a collection of invoice items associated with that item' do
      item1 = create(:item, name: 'milk')
      item2 = create(:item, name: 'juice')
      create_list(:invoice_item, 2, item: item1)
      create(:invoice_item, item: item2)

      get "/api/v1/items/#{item1.id}/invoice_items"

      json_inv_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_inv_items.count).to eq(2)
    end
  end

  context 'GET /items/:id/merchant' do
    it 'returns a merchant associated with that item' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, name: 'milk', merchant: merchant1)
      item2 = create(:item, name: 'juice', merchant: merchant2)

      get "/api/v1/items/#{item1.id}/merchant"

      json_merch = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merch.count).to eq(2)
    end
  end
end
