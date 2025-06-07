class Payment < ApplicationRecord
  belongs_to :bill

  validates :amount, numericality: { greater_than: 0 }
  validates :payment_method, presence: true, inclusion: { in: %w[mpesa bank] }
  validates :transaction_code, presence: true, uniqueness: true
  validates :paid_at, presence: true
end
