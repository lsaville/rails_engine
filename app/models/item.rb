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
end
