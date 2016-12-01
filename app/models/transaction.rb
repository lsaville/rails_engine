class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, :result, presence: true

  def self.successful
    where(result: "success")
  end
  
end
