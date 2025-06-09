class WaterReading < ApplicationRecord
  belongs_to :customer_profile

  validates :reading_date, presence: true
  validates :consumption, presence: true, numericality: { greater_than_or_equal_to: 0 }
  has_one :bill, dependent: :destroy



end
