class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: Merchant.joins(:invoices)

    # top x merchants ranked by total number of items sold
    items_sold = invoice_items.quantity *
  end
