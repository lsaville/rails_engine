class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  validates :name, presence: true

  def self.merchants_most_items(quantity)
    joins(:invoice_items).
    joins("INNER JOIN transactions ON transactions.invoice_id = invoice_items.invoice_id").
    where("transactions.result = 'success'").
    group('merchants.id').
    order("sum(invoice_items.quantity) desc").
    limit(quantity)
  end

  def self.merchants_most_revenue(quantity)
    joins(:invoice_items).
    joins(INNER JOIN transactions ON transactions.invoice_id = invoice_items.invoice_id).
    where("transactions.result = 'success'").
    group('merchants.id').
    order("sum(invoice_items.quantity * invoice_items.unit_price) desc").
    limit(quantity)
  end

  def revenue(date = nil)
    if date == nil
      invoices.joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum("invoice_items.quantity * invoice_items.unit_price")
    else
      invoices.joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .where(invoices: {created_at: date})
      .sum("invoice_items.quantity * invoice_items.unit_price")
    end
  end

  def self.most_revenue(quantity)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
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

  def favorite_customer
    customers.select("customers.*, count(transactions.id) as num_transactions")
      .joins(invoices: :transactions)
      .merge(Transaction.successful)
      .group("customers.id")
      .order("num_transactions desc")
      .first
  end
end
