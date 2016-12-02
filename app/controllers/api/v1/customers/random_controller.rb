class Api::V1::Customers::RandomController < ApplicationController
  def show
    ids = Customer.pluck(:id)
    render json: Customer.find(ids.sample)
  end
end
