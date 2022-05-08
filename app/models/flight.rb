class Flight < ApplicationRecord
  belongs_to :departure_airport, -> { readonly }, class_name: 'Airport'
  belongs_to :arrival_airport, -> { readonly }, class_name: 'Airport'

  def local_departure_time
    start_datetime.in_time_zone(departure_airport.time_zone_info.tzinfo_time_zone_name)
  end

  def local_time
    # tz = TimeZone.new(time_zone_info.base_utc_offset_hours)
    # Time.now.in_time_zone(tz)s
    Time.now.in_time_zone(time_zone_info.tzinfo_time_zone_name)
  end
end
