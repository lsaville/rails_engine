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
      create(:item)
      get "/api/v1/items/#{@item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['name']).to eq(@item.name)
    end
  end

  context 'GET /items/find?parameters' do
    it 'returns a single item based on params name' do
      create(:item)
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
    
    it 'returns a single item case insensitive' do
      create(:item, name: 'CRAZY')
      get '/api/v1/items/find?name=crazy'

      item = JSON.parse(response.body)

      expect(item['name']).to eq('CRAZY')
    end
  end

  context 'GET /items/find_all?parameters' do
    it 'returns a list of items based on the parameters' do
      create_list(:item, 3, name: 'bruce')
      get "/api/v1/items/find_all?name=bruce"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end

  context 'GET /items/random' do
    it 'returns an item randomly' do
      create_list(:item, 10)
      get '/api/v1/items/random'

      item1 = JSON.parse(response.body)

      expect(response).to be_success
      
      get '/api/v1/items/random'

      item2 = JSON.parse(response.body)

      expect(item1['id']).to_not eq(item2['id'])
    end
  end
end
