require 'rails_helper'

describe 'Items endpoints' do
  context 'GET /items' do
    it 'returns a list of all items' do
      create_list(:item, 3)
      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end

  context 'GET /items/:id' do
    it 'returns a specific item' do
      item = create(:item, name: 'Frank')
      get "/api/v1/items/#{item.id}"

      expect(response).to be_success
      expect(item.name).to eq('Frank')
    end
  end
end
