class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :accept_booking, :decline_booking]
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
    @booking.price_total = (((@booking.end_date - @booking.start_date) / 1.day) * @booking.car.price_per_day)

    if @booking.save
      redirect_to bookings_path, status: :see_other, notice: "Booking was successfully created"
    else
      render :new, status: :unprocessable_entity, notice: "Something went wrong"
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @car = @booking.car
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(booking_params)
      @booking.price_total = (((@booking.end_date - @booking.start_date) / 1.day) * @booking.car.price_per_day)
      @booking.save
      redirect_to bookings_path, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
    # redirect_to bookings_path
  end

  def accept_booking!
    # @booking.accepted!
    @booking.update(status: "accepted")
    redirect_to root_path
  end

  def decline_booking!
    # @booking.declined!
    @booking.update(status: "declined")
    redirect_to root_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
