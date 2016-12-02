require 'rails_helper'

describe 'merchants business endpoints' do
  context 'GET /merchants/:id/revenue' do
    xit "returns total revenue for a merchant" do
      customer = create(:customer, first_name: "Elvis", last_name: "Grbac")
      customer2 = create(:customer, first_name: "Mike", last_name: "Dao")
    end
  end

  context 'GET /merchants/:id/customers_with_pending_invoices' do
    it 'returns a list of customers that have pending invoices' do
      customer1 = create(:customer, first_name: 'cliff')
      customer2 = create(:customer, first_name: 'samantha')
      merchant = create(:merchant, name: 'buzz')
      invoice1 = create(:invoice, merchant: merchant, customer: customer1)
      invoice2 = create(:invoice, merchant: merchant, customer: customer2)
      transaction = create(:transaction, invoice: invoice2, result: 'failed')

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.count).to eq(1)
      expect(customer.first['first_name']).to eq('samantha')
    end
  end

  context 'GET /merchants/:id/favorite_customer' do
    it 'returns the customer who has conducted the most total number of successful transactions' do
      merchant1 = create(:merchant, name: 'Shawnee')
      merchant2 = create(:merchant, name: 'Gloria')
      customer1 = create(:customer)
      customer2 = create(:customer, first_name: 'travitz')
      invoice1 = create(:invoice, merchant: merchant1, customer: customer1)
      invoice2 = create(:invoice, merchant: merchant2, customer: customer2)
      invoice3 = create(:invoice, merchant: merchant2, customer: customer2)
      invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 1)
      invoice_item3 = create(:invoice_item, invoice: invoice3, quantity:5)
      create(:transaction, result: 'success', invoice: invoice1) 
      create(:transaction, result: 'success', invoice: invoice2)
      create(:transaction, result: 'success', invoice: invoice3)
      
      get "/api/v1/merchants/#{merchant2.id}/favorite_customer"  

      fav_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(fav_customer['first_name']).to eq('travitz')
    end
  end

  context 'GET merchants/most_revenue?quantity=x' do
    it 'returns the top x merchants ranked by total revenue' do
      merchant1 = create(:merchant, name: 'Shawnee')
      merchant2 = create(:merchant, name: 'Gloria')
      customer = create(:customer)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer)
      invoice2 = create(:invoice, merchant: merchant2, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 1)
      create(:transaction, result: 'success', invoice: invoice1) 
      create(:transaction, result: 'success', invoice: invoice2)

      get '/api/v1/merchants/most_revenue?quantity=2'
      
      merchants = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(merchants.first['name']).to eq('Shawnee')
    end
  end

  context 'GET merchants/revenue?date=x' do
    it 'returns total revenue for date x across merchants' do
      merchant1 = create(:merchant, name: 'Shawnee')
      merchant2 = create(:merchant, name: 'Gloria')
      customer = create(:customer)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer, created_at:'2012-03-27 14:54:09')
      invoice2 = create(:invoice, merchant: merchant2, customer: customer, created_at:'2012-03-27 14:54:09')
      invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 1)
      invoice_items = [invoice_item1, invoice_item2]
      create(:transaction, result: 'success', invoice: invoice1) 
      create(:transaction, result: 'success', invoice: invoice2)
      
      result = invoice_items.reduce(0) do |sum, invoice_item|
        sum += invoice_item.quantity * invoice_item.unit_price
        sum
      end

      result = (result/100.0).to_s

      date = '2012-03-27 14:54:09'

      get "/api/v1/merchants/revenue?date=#{date}"

      revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue['total_revenue']).to eq(result)
    end
  end
end
