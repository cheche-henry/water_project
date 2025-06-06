class User < ApplicationRecord
  has_secure_password

  enum :role, { customer: 0, admin: 1 }


  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, uniqueness: true, allow_blank: true
end
