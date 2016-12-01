require 'rails_helper'

describe 'Customer favorite merchant' do
  context 'GET customers/:id/favorite_merchant' do
    it "returns a customers favorite merchant" do
      customer1 = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoice1 = create(:invoice, customer: customer1, merchant: merchant1)
      invoice2 = create(:invoice, customer: customer1, merchant: merchant2)
      invoice1.transactions << create(:transaction)
      invoice1.transactions << create(:transaction, result: "failed")
      invoice2.transactions << create(:transaction)
      invoice2.transactions << create(:transaction)

      get "/api/v1/customers/#{customer1.id}/favorite_merchant"

      merchant_json = JSON.parse(response.body)
      expect(response.status).to eq 200

      expect(merchant_json["id"]).to eq merchant2.id
      expect(merchant_json["name"]).to eq merchant2.name
    end
  end
end
