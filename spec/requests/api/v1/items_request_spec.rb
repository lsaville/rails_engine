require 'rails_helper'

describe 'Items endpoints' do
  before(:each) do
    @item = create(:item, name: 'Frank')
  end

  context 'GET /items' do
    it 'returns a list of all items' do
      create_list(:item, 3)
      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(4)
    end
  end

  context 'GET /items/:id' do
    it 'returns a specific item' do
      get "/api/v1/items/#{@item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['name']).to eq(@item.name)
    end
  end

  context 'GET /items/find?parameters' do
    it 'returns a single item based on params name' do
      get "/api/v1/items/find?name=#{@item.name}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["name"]).to eq(@item.name)
    end
    
    it 'returns a single item based on id' do
      get "/api/v1/items/find?id=#{@item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq(@item.id)
    end
  end
end
