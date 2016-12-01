class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :unit_price, presence: true

  def self.most_revenue(quantity)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(invoices: :transactions)
      .merge(Transaction.successful)
      .group("items.id")
      .order("revenue desc")
      .limit(quantity)
  end

  def self.most_items(quantity)
    select("items.*, sum(quantity) as items_sold")
      .joins(invoices: :transactions)
      .where(transactions: {result: "success"})
      .group("items.id")
      .order("items_sold DESC")
      .limit(quantity)
  end
end
