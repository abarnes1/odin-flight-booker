class AddLatitudeAndLongitudeToAirport < ActiveRecord::Migration[7.0]
  def change
    add_column(:airports, :latitude, :decimal, null: false)
    add_column(:airports, :longitude, :decimal, null: false)
  end
end
