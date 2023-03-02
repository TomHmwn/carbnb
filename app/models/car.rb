class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  TRANSMISSION = %w[Automatic Manual]
  FUEL_TYPE = %w[Petrol Diesel Electric Hyrbid]
  CAR_TYPE = %w[Sedan Hachback Convertible Coupe Sports Minivan Van SUV StationWagon Truck]
  DRIVE_TYPE = %w[All-wheel Four-wheel Front-wheel Rear-wheel]
  validates :brand, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :price_per_day, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :address, presence: true
  validates :photos, presence: true
  validates :car_type, presence: true, inclusion: {in: CAR_TYPE}
  validates :fuel_type, presence: true, inclusion: {in: FUEL_TYPE}
  validates :transmission, presence: true, inclusion: {in: TRANSMISSION}
  validates :drive_type, presence: true, inclusion: {in: DRIVE_TYPE}
  validates :year, presence: true, numericality: { :greater_than_or_equal_to => 1900 }
  validates :standard_specs, presence: true
  validates :kilometrage, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :doors, presence: true, numericality: (0..5)

  attribute :remove_file, :boolean, default: false
  after_save :purge_file, if: :remove_file
end
