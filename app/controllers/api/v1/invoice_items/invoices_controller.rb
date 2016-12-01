class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def index
    render json: InvoiceItem.find(params[:id]).invoice
  end
end
