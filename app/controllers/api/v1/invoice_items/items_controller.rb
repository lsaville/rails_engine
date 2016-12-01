class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def index
    render json: InvoiceItem.find(params[:id]).item
  end
end
