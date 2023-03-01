class CarsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "brand ILIKE :query OR model ILIKE :query"
      @cars = Car.where(sql_query, query: "%#{params[:query]}%")
    else
      @cars = Car.all
    end
  end

  def new
    @car = Car.new
  end

  def show
    @car = Car.find(params[:id])
    @reviews = Review.where(car: @car)
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    @car.update(car_params)
    redirect_to car_path(@car)
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_path
  end

  def your_cars
    @cars = Car.where(user: current_user)
  end

  def your_car_bookings
    @cars = Car.where(user: current_user)
    @all_bookings = []
    @cars.each do |car|
      @all_bookings << car.bookings
    end
    @all_bookings
  end


  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :brand, :color, :price_per_day, :address, photos: [])
  end
end
