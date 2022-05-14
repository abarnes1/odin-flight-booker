class Flight < ApplicationRecord
  belongs_to :departure_airport, -> { readonly }, class_name: 'Airport'
  belongs_to :arrival_airport, -> { readonly }, class_name: 'Airport'

  def local_departure_time
    departure_datetime.in_time_zone(departure_airport.time_zone_info.rails_time_zone)
  end

  def local_time
    Time.now.in_time_zone(time_zone_info.rails_time_zone)
  end
end
