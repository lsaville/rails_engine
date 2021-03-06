class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.citext :credit_card_number
      t.citext :credit_card_expiration_date
      t.citext :result
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
