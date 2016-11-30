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
      item = create(:merchant, name: "Target")

      get "/api/v1/merchants/#{Merchant.first.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["name"]).to eq("Target")
    end
  end

  context 'GET /merchants/find?params' do
    it 'finds record by params search' do
      merchant = create(:merchant, name: "Walmart")

      get "/api/v1/merchants/find?name=Walmart"

      expect(response).to be_success
      expect(merchant["name"]).to eq("Walmart")
    end
  end

  context 'GET /merchants/find_all?params' do
    it 'finds all records by params search' do
      merchant = create(:merchant, name: "Safeway")
      merchant2 = create(:merchant, name: "Target")
      merchant3 = create(:merchant, name: "Walmart")

      get "/api/v1/merchants/find_all?name=Safeway"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end
end
