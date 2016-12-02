require 'rails_helper'

describe 'Invoice item relationship endpoints' do
  context 'GET :id/invoice' do
    it 'returns the associated invoice' do
      invoice1 = create(:invoice, status: "paid")
      invoice2 = create(:invoice, status: "unpaid")
      invoice_item1 = create(:invoice_item, invoice: invoice1)

      get "/api/v1/invoice_items/#{invoice_item1.id}/invoice"

      invoice_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_json["status"]).to eq("paid")
    end
  end

  context 'GET :id/item' do
    it 'returns the associated item' do
      item1 = create(:item, name: "milk")
      item2 = create(:item, name: "juice")
      invoice_item1 = create(:invoice_item, item: item1)

      get "/api/v1/invoice_items/#{invoice_item1.id}/item"

      item_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_json["name"]).to eq("milk")
    end
  end
end
