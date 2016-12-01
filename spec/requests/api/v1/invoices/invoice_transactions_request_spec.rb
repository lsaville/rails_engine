require 'rails_helper'

RSpec.describe "Invoice transactions" do
  xit "returns a collection of associated transactions" do

    get "/api/v1/invoices/#{invoice_1.id}/transaction"
    invoice_response = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_response.count).to be(3)
    expect(invoice_response.first["id"]).to eq(invoice_1.transactions.first.id)
  end
end
