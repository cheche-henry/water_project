class CreateWaterReadings < ActiveRecord::Migration[8.0]
  def change
    create_table :water_readings do |t|
      t.references :customer_profile, null: false, foreign_key: true
      t.date :reading_date
      t.decimal :consumption
      t.boolean :billed

      t.timestamps
    end
  end
end
