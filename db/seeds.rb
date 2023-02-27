# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clearing old data
puts "Clearing out old data"
Car.destroy_all
User.destroy_all
# Booking.destroy_all

# Creating users
puts "Creating users"
10.times {
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email # "#{first_name}#{last_name}@gmail.com"
  password = "123456"
  new_user = User.new(first_name:, last_name:, email:, password:)
  new_user.save!
}
puts "Finished creating users"

# Creating cars
puts "Creating cars"
10.times {
  # puts "#{User.all.sample}"
  user_id = User.all.sample.id
  color = Faker::Vehicle.color
  fake_car = Faker::Vehicle.make_and_model.split
  brand = fake_car.first
  model = fake_car.last
  address = Faker::Address.street_address
  price_per_day = rand(50..100)
  new_car = Car.new(color:, model:, brand:, price_per_day:, user_id:, address:)
  new_car.photo.attach(io: URI.open("http://loremflickr.com/280/280/#{brand}#{model}"), filename: "#{brand}_#{model}.png", content_type: 'image/png');
  p new_car.photo.attached?
  new_car.save!
}
puts "Finished creating cars"
