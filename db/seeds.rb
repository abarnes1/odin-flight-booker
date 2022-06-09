# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

alaska_time = TimeZoneInfo.create(
  rails_time_zone: 'Alaska',
  iana_time_zone: 'America/Juneau',
  standard_utc_offset_hours: -9,
  daylight_savings_utc_offset_hours: -8
)

pacific_time = TimeZoneInfo.create(
  rails_time_zone: 'Pacific Time (US & Canada)',
  iana_time_zone: 'America/Los_Angeles',
  standard_utc_offset_hours: -8,
  daylight_savings_utc_offset_hours: -7
)

mountain_time = TimeZoneInfo.create(
  rails_time_zone: 'Mountain Time (US & Canada)',
  iana_time_zone: 'America/Denver',
  standard_utc_offset_hours: -7,
  daylight_savings_utc_offset_hours: -6
)

central_time = TimeZoneInfo.create(
  rails_time_zone: 'Central Time (US & Canada)',
  iana_time_zone: 'America/Chicago',
  standard_utc_offset_hours: -6,
  daylight_savings_utc_offset_hours: -5
)

eastern_time = TimeZoneInfo.create(
  rails_time_zone: 'Eastern Time (US & Canada)',
  iana_time_zone: 'America/New_York',
  standard_utc_offset_hours: -5,
  daylight_savings_utc_offset_hours: -4
)

Airport.create(
  [
    { code: 'DEN', name: 'Denver', time_zone_info: mountain_time, latitude: 39.8560963, longitude: -104.67373759999998 },
    { code: 'DFW', name: 'Dallas - Fort Worth', time_zone_info: central_time, latitude: 32.8998091, longitude: -97.04033520000002 },
    { code: 'CLE', name: 'Cleveland', time_zone_info: eastern_time, latitude: 41.412434, longitude: -81.847992 },
    { code: 'MCI', name: 'Kansas City', time_zone_info: central_time, latitude: 39.3006427, longitude: -94.71259370000001 },
    { code: 'MCO', name: 'Orlando', time_zone_info: eastern_time, latitude: 28.4311577, longitude: -81.308083 },
    { code: 'ANC', name: 'Anchorage', time_zone_info: alaska_time, latitude: 61.175886, longitude: -149.990079 },
    { code: 'LAX', name: 'Los Angeles', time_zone_info: pacific_time, latitude: 33.9415889, longitude: -118.40853 },
  ]
)
