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

  private

  def set_car
    @car = Car.find(params[:id])
  end
  def car_params
    params.require(:car).permit(:model, :brand, :color, :price_per_day, :address, photos: [])
  end
end
