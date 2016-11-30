class Api::V1::Merchants::InvoiceController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).invoices
  end
end
