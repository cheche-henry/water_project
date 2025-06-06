class CustomerProfile < ApplicationRecord
  belongs_to :user

  validates :meter_number, presence: true, uniqueness: true
  validates :address, presence: true
  validate :user_must_be_customer

  has_many :water_readings, dependent: :destroy
  has_many :bills, dependent: :destroy



  private

  def user_must_be_customer
    errors.add(:user, "must be a customer") unless user&.customer?
  end
end
