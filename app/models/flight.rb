class Flight < ApplicationRecord
  belongs_to :departure_airport, -> { readonly }, class_name: 'Airport'
  belongs_to :arrival_airport, -> { readonly }, class_name: 'Airport'

  def local_departure_time
    departure_datetime.in_time_zone(departure_airport.local_time_zone)
  end

  def local_arrival_time
    (departure_datetime + duration.minutes).in_time_zone(arrival_airport.local_time_zone)
  end
end
