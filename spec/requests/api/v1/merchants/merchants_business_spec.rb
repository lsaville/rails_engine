require 'rails_helper'

describe 'merchants business endpoints' do
  context 'GET /merchants/:id/revenue' do
    xit "returns total revenue for a merchant" do
      customer = create(:customer, first_name: "Elvis", last_name: "Grbac")
      customer2 = create(:customer, first_name: "Mike", last_name: "Dao")
    end
  end

  context 'GET /merchants/:id/customers_with_pending_invoices' do
    xit 'returns a list of customers that have pending invoices' do
      customer1 = create(:customer, first_name: 'cliff')
      customer2 = create(:customer, first_name: 'samantha')
      merchant = create(:merchant, name: 'buzz')
      create(:invoice, merchant: merchant, customer: customer1, status: 'pending')
      create(:invoice, merchant: merchant, customer: customer2)

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(1)
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
