class CreateCustomerProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :customer_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :meter_number
      t.string :address

      t.timestamps
    end
  end
end
