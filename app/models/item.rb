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

  def best_day
    invoices
      .select("invoices.created_at", "SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
      .joins(:transactions)
      .where("result='success'")
      .group('created_at')
      .reorder('total_revenue DESC')
      .take(1)
      .first
  end
end
