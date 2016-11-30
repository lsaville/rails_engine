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
      customer = create(:customer, first_name: "John", last_name: "Elway")

      get "/api/v1/customers/#{Customer.first.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq("John")
      expect(customer["last_name"]).to eq("Elway")
    end
  end

  context 'GET /customers/find?params' do
    it 'finds record by params search' do
      customer = create(:customer, first_name: "John", last_name: "Elway")
      customer = create(:customer, first_name: "Peyton", last_name: "Manning")

      get "/api/v1/customers/find?first_name=Peyton&last_name=Manning"

      expect(response).to be_success
      expect(customer["first_name"]).to eq("Peyton")
      expect(customer["last_name"]).to eq("Manning")
    end
  end

  context 'GET /customers/find_all?params' do
    it 'finds all records by params search' do
      customer = create(:customer, first_name: "John", last_name: "Elway")
      customer2 = create(:customer, first_name: "Peyton", last_name: "Manning")
      customer3 = create(:customer, first_name: "Peyton", last_name: "Smith")

      get "/api/v1/customers/find_all?first_name=Peyton"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
    end
  end

end
