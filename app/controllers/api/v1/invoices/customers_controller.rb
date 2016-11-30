class Api::V1::Invoices::CustomersController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    render json: invoice.customers
  end
end
