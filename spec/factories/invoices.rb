FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    status "shipped"
  end

  factory :invoice_with_transactions, parent: :invoice do |invoice|
    transactions { build_list :transaction, Random.rand(1..6) }
  end
end
