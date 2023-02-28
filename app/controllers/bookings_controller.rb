class BookingsController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @booking = Booking.new
  end

  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @bookings = Booking.all
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @car = Car.find(params[:car_id])
    @booking.car = @car
    @booking.price_total = (@booking.end_date - @booking.start_date).to_i * @booking.car.price_per_day

    if @booking.save
      redirect_to bookings_path, status: :see_other, notice: "Booking was successfully created"
    else
      render :new, status: :unprocessable_entity, notice: "Something went wrong"
    end
    # check if car is already booked
    # @bookings.select { |booking| booking.car == @booking.car }.each do |booking|
    #   # if (@booking.start_date > booking.end_date && @booking.end_date < booking.start_date)
    #   # end
    # end
    # if @booking.save
    #   redirect_to bookings_path
    # # check if user is trying to book his own car
    # elsif (@booking.car.user == current_user)
    #   render :new, status: :unprocessable_entity, notice: "You can't book your own car"
    # # xcheck if user is trying to book a car in the past
    # elsif (@booking.start_date < Date.today || @booking.end_date < Date.today)
    #   render :new, status: :unprocessable_entity, notice: "wrong dates"
    # # check if user is trying to book a car with start date after end date
    # elsif (@booking.start_date > @booking.end_date)
    #   render :new, status: :unprocessable_entity, notice: "wrong dates"
    # # check if user is trying to book a car with start date in the past
    # elsif (@booking.start_date < Date.today && @booking.end_date < Date.today)
    #   render :new, status: :unprocessable_entity, notice: "wrong dates"
    # else
    #   render :new, status: :unprocessable_entity, notice: "something went wrong"
    # end
  end

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
