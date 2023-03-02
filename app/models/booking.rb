class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car

  enum :status, { pending: 0, accepted: 1, declined: 2 }

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_in_the_past
  validate :start_date_cannot_be_after_end_date
  validate :car_is_not_already_booked_for_this_period
  validate :user_is_not_booking_his_own_car


  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end
  def end_date_cannot_be_in_the_past
    if end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
  def start_date_cannot_be_after_end_date
    if start_date > end_date
      errors.add(:start_date, "can't be after end date")
    end
  end
  def car_is_not_already_booked_for_this_period
    if car.bookings.any? { |booking| booking.start_date < end_date && booking.end_date > start_date && booking != self }
      errors.add(:car, "is already booked")
    end
  end
  def user_is_not_booking_his_own_car
    if car.user == user
      errors.add(:car, "can't be your own car")
    end
  end
end
