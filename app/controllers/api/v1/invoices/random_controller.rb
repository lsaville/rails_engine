class Api::V1::Invoices::RandomController < ApplicationController 
  def show
    ids = Invoice.pluck(:id)
    render json: Invoice.find(ids.sample)
  end
end
