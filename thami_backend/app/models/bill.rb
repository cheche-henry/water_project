class Bill < ApplicationRecord
  belongs_to :customer_profile
  belongs_to :water_reading
end
