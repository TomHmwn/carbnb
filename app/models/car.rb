class Car < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  attribute :remove_file, :boolean, default: false
  after_save :purge_file, if: :remove_file
end
