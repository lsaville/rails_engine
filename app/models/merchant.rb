class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  validates :name, presence: true

  def self.merchants_most_items(quantity)
    joins(:invoice_items).
    joins("INNER JOIN transactions ON transactions.invoice_id = invoice_items.invoice_id").
    where("transactions.result = 'success'").
    group('merchants.id').
    order("sum(invoice_items.quantity) desc").
    limit(quantity)
  end

end
