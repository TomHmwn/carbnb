class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :brand, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :price_per_day, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :address, presence: true
  validates :photos, presence: true
  validates :car_type, presence: true
  validates :fuel_type, presence: true
  validates :transmission, presence: true
  validates :drive_type, presence: true
  validates :year, presence: true, numericality: { :greater_than_or_equal_to => 1900 }
  validates :standard_specs, presence: true
  validates :kilometrage, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :doors, presence: true, numericality: (0..5)

  attribute :remove_file, :boolean, default: false
  after_save :purge_file, if: :remove_file
end
