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

  context 'GET /customers/find?parameters' do
    it 'returns an customer based on the string query params' do
      create_list(:customer, 3)
      create(:customer, first_name: 'Gus')

      get '/api/v1/customers/find?first_name=Gus'

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['first_name']).to eq('Gus')
    end
  end

  context 'GET /customers/find_all?params' do
    it 'returns all customers matching the params' do
      create_list(:customer, 3, first_name: 'Steve')
      create_list(:customer, 1, first_name: 'Joe')

      get '/api/v1/customers/find_all?first_name=Steve'

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end

  context 'GET /customers/random' do
    it 'returns an customer randomly' do
      create_list(:customer, 50)
      get '/api/v1/customers/random'

      customer1 = JSON.parse(response.body)

      expect(response).to be_success

      get '/api/v1/customers/random'

      customer2 = JSON.parse(response.body)

      expect(customer1['id']).to_not eq(customer2['id'])
    end
  end

end
