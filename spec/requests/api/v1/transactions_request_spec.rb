require 'rails_helper'

describe 'transactions endpoints' do
  context 'GET /transactions' do
    it "returns a list of all transactions" do
      list = create_list(:transaction, 3)

      get "/api/v1/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end

  context 'GET /transactions' do
    it "returns one transaction" do
      item = create(:transaction, credit_card_number: "1234567812345678", result: "success")

      get "/api/v1/transactions/#{Transaction.first.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["credit_card_number"]).to eq("1234567812345678")
      expect(item["result"]).to eq("success")
    end
  end

end
