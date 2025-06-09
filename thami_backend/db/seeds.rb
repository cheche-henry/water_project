# Create an admin user
admin = User.create!(
  name: "Admin User",
  phone_number: "0712345678",
  email: "admin@example.com",
  password: "adminpass",
  role: :admin
)

# Create a customer user
customer = User.create!(
  name: "John Customer",
  phone_number: "0723456789",
  password: "securepass",
  role: :customer
)

# Create a customer profile linked to that user
profile = CustomerProfile.create!(
  user: customer,
  meter_number: "MTR123456",
  address: "123 Water Street"
)

# Create a water reading linked to the profile
reading = WaterReading.create!(
  customer_profile: profile,
  reading_date: Date.today,
  consumption: 150
)

# Create a bill linked to the profile and reading
bill = Bill.create!(
  customer_profile: profile,
  water_reading: reading,
  amount: 750,
  status: "pending"
)

# Create a payment linked to the bill
Payment.create!(
  bill: bill,
  amount: 750,
  payment_method: "mpesa",
  transaction_code: "TXN123456",
  paid_at: Time.now
)

puts "✅ Seeded admin, customer, profile, reading, bill, and payment!"
