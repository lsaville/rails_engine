require 'rails_helper'

describe 'Merchant Relationship Endpoints' do
  context 'GET /merchants/:id/items' do
    it 'returns a collection of items associated with that merchant' do
      merchant1 = create(:merchant, name: 'Jill')
      merchant2 = create(:merchant, name: 'Rogelio')
      create_list(:item, 2, merchant: merchant1)
      create(:item, merchant: merchant2)

      get "/api/v1/merchants/#{merchant1.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
    end
  end
end
