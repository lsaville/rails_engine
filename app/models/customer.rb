class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  validates :first_name, :last_name, presence: true

  scope :successful, -> { where(result: 'success') }

  def favorite_merchant
    merchants
    .joins(:transactions)
    .merge(Transaction.successful)
    .group('merchants.id')
    .order("count(*) desc")
    .first
  end
end
