class CreateBills < ActiveRecord::Migration[8.0]
  def change
    create_table :bills do |t|
      t.references :customer_profile, null: false, foreign_key: true
      t.references :water_reading, null: false, foreign_key: true
      t.decimal :amount
      t.date :due_date
      t.string :status

      t.timestamps
    end
  end
end
