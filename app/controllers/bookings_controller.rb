class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end
  def index
    @bookings = Booking.where(user: current_user)
  end
  def create
    @bookings = Booking.all
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.car = Car.find(params[:car_id])
    @booking.price_total = (@booking.end_date - @booking.start_date).to_i * @booking.car.price_per_day

    # check if car is already booked
    @bookings.select { |booking| booking.car == @booking.car }.each do |booking|
      if (@booking.start_date < booking.end_date && @booking.end_date > booking.start_date)
        render :new, status: :unprocessable_entity, notice: "Car already booked"
      end
    end
    if @booking.save
      redirect_to booking_path
    # check if user is trying to book his own car
    elsif (@booking.car.user == current_user)
      render :new, status: :unprocessable_entity, notice: "You can't book your own car"
    # check if user is trying to book a car in the past
    elsif (@booking.start_date < Date.today || @booking.end_date < Date.today)
      render :new, status: :unprocessable_entity, notice: "wrong dates"
    # check if user is trying to book a car with start date after end date
    elsif (@booking.start_date > @booking.end_date)
      render :new, status: :unprocessable_entity, notice: "wrong dates"
    # check if user is trying to book a car with start date in the past
    elsif (@booking.start_date < Date.today && @booking.end_date < Date.today)
      render :new, status: :unprocessable_entity, notice: "wrong dates"
    else
      render :new, status: :unprocessable_entity, notice: "something went wrong"
    end
  end
end
