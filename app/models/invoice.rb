class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  validates :status, presence: true

  scope :by_date, -> (date) { where("invoices.created_at >= ? AND invoices.created_at <= ?",
                                     date.beginning_of_day,
                                     date.end_of_day)
                             } 
end
