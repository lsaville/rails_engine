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

end
