class Airport < ApplicationRecord
  has_many :arriving_flights, class_name: 'Flight', foreign_key: 'arrival_airport_id'
  has_many :departing_flights, class_name: 'Flight', foreign_key: 'departure_airport_id'

  before_save :standardize_case

  private

  def standardize_case
    code.upcase!
    self.name = name.split.each(&:capitalize).join(' ')
  end
end
