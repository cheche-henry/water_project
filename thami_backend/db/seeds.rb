User.create!(
  name: "Admin User",
  phone_number: "0712345678",
  email: "admin@example.com",
  password: "password123",
  role: :admin
)

User.create!(
  name: "John Customer",
  phone_number: "0723456789",
  password: "securepass",
  role: :customer
)
puts "✅ Done seeding!"