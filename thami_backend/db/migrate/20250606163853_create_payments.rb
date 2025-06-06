class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :bill, null: false, foreign_key: true
      t.decimal :amount
      t.string :payment_method
      t.string :transaction_code
      t.datetime :paid_at

      t.timestamps
    end
  end
end
