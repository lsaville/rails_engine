require 'rails_helper'

describe 'Invoice Relationship Endpoints' do
  context 'GET /invoices/:id/transactions' do
    it 'returns a collection of transactions associated with that merchant' do
      invoice1 = create(:invoice, status: 'paid')
      invoice2 = create(:invoice, status: 'unpaid')
      create_list(:transaction, 2, invoice: invoice1)
      create(:transaction, invoice: invoice2)

      get "/api/v1/invoices/#{invoice1.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end

  context 'GET /invoices/:id/customer' do
    it 'returns a customer associated with that invoice' do
      customer1 = create(:customer, first_name: "Lee")
      customer2 = create(:customer)
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/#{invoice1.id}/customer"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq("Lee")
    end
  end

  context 'GET /invoices/:id/invoice_items' do
    it 'returns a collection of invoice items associated with that invoice' do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      create_list(:invoice_item, 2, invoice: invoice1)
      create(:invoice_item, invoice: invoice2)

      get "/api/v1/invoices/#{invoice1.id}/invoice_items"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
    end
  end

  context 'GET /invoices/:id/items' do
    it 'returns a collection of items associated with that invoice' do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      item1, item2 = create_list(:item, 2)
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1)
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item2)

      get "/api/v1/invoices/#{invoice1.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
    end
  end

  context 'GET /invoices/:id/merchant' do
    it 'returns the merchant associated with that invoice' do
      merchant1 = create(:merchant, name: "Peets")
      merchant2 = create(:merchant, name: "Safeway")
      invoice1 = create(:invoice, merchant: merchant1)
      invoice2 = create(:invoice, merchant: merchant2)

      get "/api/v1/invoices/#{invoice1.id}/merchant"

      merchant_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_json["name"]).to eq("Peets")
    end
  end
end
