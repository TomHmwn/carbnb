class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy accept decline]
  def new
    @car = Car.find(params[:car_id])
    @booking = Booking.new
  end

  def index
    @bookings = Booking.where(user: current_user)
  end

  def show
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
    @car = @booking.car
  end

  def update
    if @booking.update(booking_params)
      @booking.price_total = (((@booking.end_date - @booking.start_date) / 1.day) * @booking.car.price_per_day)
      @booking.save
      redirect_to bookings_path, notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
    # redirect_to bookings_path
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  def accept
    if @booking.status_accepted!
      redirect_to users_cars_bookings_path, notice: 'Booking accepted'
    else
      redirect_to users_cars_bookings_path, notice: 'Booking could not be accepted - please try again'
    end
  end

  def decline
    if @booking.status_declined!
      redirect_to users_cars_bookings_path, notice: 'Booking declined'
    else
      redirect_to users_cars_bookings_path, notice: 'Booking could not be declined - please try again'
    end
  end


  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
