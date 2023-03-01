class ReviewsController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.car = Car.find(params[:car_id])
    if @review.save
      redirect_to car_path(@review.car)
    else
      render :new, status: :unprocessable_entity, notice: "Review not saved"
    end
  end
end
