class AddTimeZoneInfoToAirport < ActiveRecord::Migration[7.0]
  def change
    add_reference(:airports, :time_zone_info, foreign_key: true)
  end
end
