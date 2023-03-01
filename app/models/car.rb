class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos

  validates :brand, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :price_per_day, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :address, presence: true
  validates :photos, presence: true

  attribute :remove_file, :boolean, default: false
  after_save :purge_file, if: :remove_file
end
