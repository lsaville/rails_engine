require 'rails_helper'

describe 'merchants endpoints' do
  context 'GET /merchants' do
    it "returns a list of all merchants" do
      list = create_list(:merchant, 3)

      get "/api/v1/merchants"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end

  context 'GET /merchants' do
    it "returns one merchant" do
      merchant = create(:merchant, name: "Target")

      get "/api/v1/merchants/#{Merchant.first.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq("Target")
    end
  end

  context 'GET /merchants/random' do
    it 'returns a merchant randomly' do
      create_list(:merchant, 100)
      get '/api/v1/merchants/random'

      merchant1 = JSON.parse(response.body)

      expect(response).to be_success

      get '/api/v1/merchants/random'

      merchant2 = JSON.parse(response.body)

      expect(merchant1['id']).to_not eq(merchant2['id'])
    end
  end

  context 'GET /merchants/find?parameters' do
    it 'returns a single merchant based on params name' do

      merchant = create(:merchant, name: "Target")
      get "/api/v1/merchants/find?result=#{merchant.name}"

      json_result= JSON.parse(response.body)

      expect(response).to be_success
      expect(json_result["name"]).to eq(merchant.name)
    end

    it 'returns a single merchant based on id' do
      merchant = create(:merchant, name: "Starbucks")
      get "/api/v1/merchants/find?id=#{merchant.id}"
      json_result = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_result['id']).to eq(merchant.id)
    end

    it 'returns a single merchant case insensitive' do
      merchant = create(:merchant, name: "Starbucks")
      get '/api/v1/merchants/find?name=starbucks'

      json_result = JSON.parse(response.body)

      expect(json_result['name']).to eq('Starbucks')
    end
  end

  context 'GET /merchants/find_all?parameters' do
    it 'returns a list of merchants based on the parameters' do
      create_list(:merchant, 3, name: 'Walmart')
      create(:merchant, name: "McDonalds")

      get "/api/v1/merchants/find_all?name=Walmart"

      results = JSON.parse(response.body)

      expect(response).to be_success
      expect(results.count).to eq(3)
    end
  end

end
