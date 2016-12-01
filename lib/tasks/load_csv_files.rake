require 'csv'

namespace :load_csv_files do
  desc "load customers"
  task customers: :environment do
    CSV.foreach('./lib/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "load invoices"
  task invoices: :environment do
    CSV.foreach('./lib/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)

    end
  end

  desc "load invoice_items"
  task invoice_items: :environment do
    CSV.foreach('./lib/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "load items"
  task items: :environment do
    CSV.foreach('./lib/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
      # Item.create(id: row["id"],
      #             name: row["name"],
      #             unit_price: (row["unit_price"].to_i/100.00))
    end
  end

  desc "load merchants"
  task merchants: :environment do
    CSV.foreach('./lib/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "load transactions"
  task transactions: :environment do
    CSV.foreach('./lib/data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task :all => [:merchants, :customers, :invoices, :transactions, :items, :invoice_items]
end
