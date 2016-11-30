require 'rails_helper'

describe 'merchants business endpoints' do
  context 'GET /merchants/:id/revenue' do
    it "returns total revenue for a merchant" do
      customer = create(:customer, first_name: "Elvis", last_name: "Grbac")
      customer2 = create(:customer, first_name: "Mike", last_name: "Dao")


    end
  end
end
