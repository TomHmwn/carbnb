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
Booking.destroy_all

# Creating users
puts "Creating users"
5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email # "#{first_name}#{last_name}@gmail.com"
  password = "123456"
  new_user = User.new(first_name:, last_name:, email:, password:)
  new_user.save!
end
puts "Finished creating users"

# Creating cars
puts "Creating cars"
5.times do
  # puts "#{User.all.sample}"
  user_id = User.all.sample.id
  color = Faker::Vehicle.color
  fake_car = Faker::Vehicle.make_and_model.split
  brand = fake_car.first
  model = fake_car.last
  car_type = Faker::Vehicle.car_type
  fuel_type = Faker::Vehicle.fuel_type
  transmission = Faker::Vehicle.transmission
  drive_type = Faker::Vehicle.drive_type
  year = rand(1990..2021)
  standard_specs = Faker::Vehicle.standard_specs.join(", ")
  kilometrage = rand(1000..100000)
  doors = rand(2..5)
  address = Faker::Address.street_address
  price_per_day = rand(50..100)
  new_car = Car.new(color:, model:, brand:, price_per_day:, user_id:, address:, car_type:, fuel_type:, transmission:, drive_type:, year:, standard_specs:, kilometrage:, doors:)
  2.times do
    new_car.photos.attach(io: URI.open("https://source.unsplash.com/random/?#{brand},#{model}"),
                          filename: "#{brand}_#{model}.png", content_type: 'image/png')
    p new_car.photos.attached?
  end
  new_car.save!
end

# # Creating bookings
# puts "Creating bookings"
# 5.times do
#   user_id = User.all.sample.id
#   user_id = User.all.sample.id while (Booking.find(user_id:).empty?)

#   car_id = Car.all.sample.id
#   car_id = Car.all.sample.id while (Booking.find(car_id:).emtpy?)
#   start_date = Date.today
#   end_date = Faker::Date.forward(days: 14)
#   new_booking = Booking.new(user_id:, car_id:, start_date:, end_date:)
#   new_booking.save!
# end

puts "Finished creating cars"
