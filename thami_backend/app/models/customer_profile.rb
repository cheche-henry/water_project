class CustomerProfile < ApplicationRecord
  belongs_to :user

  validates :meter_number, presence: true, uniqueness: true
  validates :address, presence: true
end
