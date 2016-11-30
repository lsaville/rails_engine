class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    ids = InvoiceItem.pluck(:id)
    render json: InvoiceItem.find(ids.sample)
  end
end
