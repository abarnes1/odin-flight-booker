# frozen_string_literal: true

# Adds functions required to use the haversine distance formula.
module Haversine
  EARTH_RADIUS_MILES = 3958.8
  EARTH_RADIUS_KM = 6371

  # Calculates the distance between two points on the surface of a sphere given two
  # pairs of latitude and longitude expressed in decimal degrees.
  # rubocop:disable Metrics/AbcSize
  def self.haversine_formula(latitude1, longitude1, latitude2, longitude2, sphere_radius = EARTH_RADIUS_MILES)
    lat1 = radians(latitude1)
    lat2 = radians(latitude2)
    delta_lat = radians(latitude2 - latitude1)
    delta_long = radians(longitude2 - longitude1)

    a = Math.sin(delta_lat / 2.0)**2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(delta_long / 2.0)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    sphere_radius * c
  end
  # rubocop:enable Metrics/AbcSize

  private_class_method def self.radians(degrees)
    degrees * Math::PI / 180
  end
end
