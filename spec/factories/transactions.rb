FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "MyNumber"
    credit_card_expiration_date "MyCCDate"
    result "MyResult"
  end
end
