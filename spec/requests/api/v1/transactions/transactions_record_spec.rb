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
      transaction = create(:transaction, credit_card_number: "1234567812345678", result: "success")

      get "/api/v1/transactions/#{Transaction.first.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["credit_card_number"]).to eq("1234567812345678")
      expect(transaction["result"]).to eq("success")
    end
  end

  context 'GET /transactions/find?parameters' do
    it 'returns a single transaction based on params name' do
      transaction = create(:transaction, credit_card_number: "1234567812345678", result: "success")
      get "/api/v1/transactions/find?result=#{transaction.result}"

      json_result = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_result["result"]).to eq(transaction.result)
    end

    it 'returns a single transaction based on id' do
      transaction = create(:transaction, credit_card_number: "1234567812345678", result: "success")
      get "/api/v1/transactions/find?id=#{transaction.id}"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result['id']).to eq(transaction.id)
    end

    it 'returns a single transaction case insensitive' do
      transaction = create(:transaction, credit_card_number: "1234567812345678", result: "success")
      get '/api/v1/transactions/find?result=SUCcess'

      result_json = JSON.parse(response.body)

      expect(result_json["result"]).to eq("success")
    end
  end

  context 'GET /transactions/find_all?parameters' do
    it 'returns a list of transactions based on the parameters' do
      create_list(:transaction, 3, result: 'success')
      create(:transaction, credit_card_number: "1234567812345678", result: "failure")

      get "/api/v1/transactions/find_all?result=success"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end

  context 'GET /transactions/random' do
    it 'returns an transaction randomly' do
      create_list(:transaction, 50)
      get '/api/v1/transactions/random'

      transaction1 = JSON.parse(response.body)

      expect(response).to be_success

      get '/api/v1/transactions/random'

      transaction2 = JSON.parse(response.body)

      expect(transaction1['id']).to_not eq(transaction2['id'])
    end
  end

end
