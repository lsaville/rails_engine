class Api::V1::Transactions::RandomController < ApplicationController
  def show
    ids = Transaction.pluck(:id)
    render json: Transaction.find(ids.sample)
  end
end
