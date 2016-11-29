require 'rails_helper'

describe 'customers endpoints' do
  context 'GET /customers' do
    it "returns a list of all customers" do
      list = create_list(:customer, 3)

      get "/api/v1/customers"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end

  context 'GET /customers' do
    it "returns one customer" do
      item = create(:customer, first_name: "John", last_name: "Elway")

      get "/api/v1/customers/#{Customer.first.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["first_name"]).to eq("John")
      expect(item["last_name"]).to eq("Elway")
    end
  end

end
