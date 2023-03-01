class Review < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: (0..5).to_a }
  validates :content, presence: true
end
