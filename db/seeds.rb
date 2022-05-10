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
    { code: 'MEM', name: 'Memphis', time_zone_info: central_time },
    { code: 'DEN', name: 'Denver', time_zone_info: mountain_time },
    { code: 'MKE', name: 'Milwaukee', time_zone_info: central_time },
    { code: 'DFW', name: 'Dallas - Fort Worth', time_zone_info: central_time },
    { code: 'CLE', name: 'Cleveland', time_zone_info: eastern_time },
    { code: 'MCI', name: 'Kansas City', time_zone_info: central_time },
    { code: 'MCO', name: 'Orlando', time_zone_info: eastern_time },
    { code: 'ANC', name: 'Anchorage', time_zone_info: alaska_time },
    { code: 'LAX', name: 'Los Angeles', time_zone_info: pacific_time },
    { code: 'LIT', name: 'Little Rock', time_zone_info: central_time }
  ]
)

denver = Airport.find_by_code('DEN')
memphis = Airport.find_by_code('MEM')
orlando = Airport.find_by_code('MCO')

Flight.create(
  arrival_airport: denver,
  departure_airport: memphis,
  start_datetime: Time.now.utc + 2.days,
  duration: 60
)

Flight.create(
  arrival_airport: denver,
  departure_airport: memphis,
  start_datetime: Time.now.utc + 1.days,
  duration: 45
)

Flight.create(
  arrival_airport: denver,
  departure_airport: memphis,
  start_datetime: Time.new.utc + 6.months + 1.days,
  duration: 45
)

Flight.create(
  arrival_airport: denver,
  departure_airport: orlando,
  start_datetime: Time.new(2022, 6, 1, 22, 15, 0, '-04:00').utc,
  duration: 777
)

Flight.create(
  arrival_airport: denver,
  departure_airport: orlando,
  start_datetime: Time.new(2022, 6, 1, 22, 15, 0, 'UTC'),
  duration: 45
)
