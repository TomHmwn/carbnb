class ReviewsController < ApplicationController
  before_action :set_car, only: [:new, :create]
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.car = @car
    if @review.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity, notice: "Review not saved"
    end
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
