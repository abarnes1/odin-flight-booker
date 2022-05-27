class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, dependent: :destroy
end
