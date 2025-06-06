class Bill < ApplicationRecord
  belongs_to :customer_profile
  belongs_to :water_reading

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[pending paid overdue] }

end
