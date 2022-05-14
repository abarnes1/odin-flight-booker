# frozen_string_literal: true

require_relative 'modules/haversine'

# Calculates flight duration between two airports.
class FlightDurationCalculator
  include Haversine

  def self.air_speed_747_mph
    460..575
  end

  def self.flight_minutes(airport1, airport2, speed = rand(air_speed_747_mph))
    miles_between = Haversine.haversine_formula(airport1.latitude, airport1.longitude, airport2.latitude, airport2.longitude)
    (miles_between / speed * 60).round
  end
end
