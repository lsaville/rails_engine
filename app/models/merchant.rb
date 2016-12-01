class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  validates :name, presence: true

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(:invoice_items)
      .joins("join transactions on transactions.invoice_id = invoices.id")
      .merge(Transaction.successful)
      .group("merchants.id")
      .order("revenue desc")
      .limit(quantity)
  end

  def self.day_revenue(date)
    joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.successful)
      .where("invoices.created_at = ?", date)
      .sum("quantity * unit_price")
  end
end
