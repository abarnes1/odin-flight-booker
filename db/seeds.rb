# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# TimeZone.us_zones.map { |zone| [zone.name, zone.tzinfo.abbr, zone.tzinfo.utc_offset/3600, zone.tzinfo.base_utc_offset/3600] }

alaska = TimeZoneInfo.create(tzinfo_time_zone_name: 'Alaska', base_utc_offset_hours: -9)
pacific = TimeZoneInfo.create(tzinfo_time_zone_name: 'Pacific Time (US & Canada)', base_utc_offset_hours: -8)
mountain = TimeZoneInfo.create(tzinfo_time_zone_name: 'Mountain Time (US & Canada)', base_utc_offset_hours: -7)
central = TimeZoneInfo.create(tzinfo_time_zone_name: 'Central Time (US & Canada)', base_utc_offset_hours: -6)
eastern = TimeZoneInfo.create(tzinfo_time_zone_name: 'Eastern Time (US & Canada)', base_utc_offset_hours: -5)

Airport.create(
  [
    { code: 'MEM', name: 'Memphis', time_zone_info: central },
    { code: 'DEN', name: 'Denver', time_zone_info: mountain },
    { code: 'MKE', name: 'Milwaukee', time_zone_info: central },
    { code: 'DFW', name: 'Dallas - Fort Worth', time_zone_info: central },
    { code: 'CLE', name: 'Cleveland', time_zone_info: eastern },
    { code: 'MCI', name: 'Kansas City', time_zone_info: central },
    { code: 'MCO', name: 'Orlando', time_zone_info: eastern },
    { code: 'ANC', name: 'Anchorage', time_zone_info: alaska },
    { code: 'LAX', name: 'Los Angeles', time_zone_info: pacific },
    { code: 'LIT', name: 'Little Rock', time_zone_info: central }
  ]
)

denver = Airport.find_by_code('DEN')
memphis = Airport.find_by_code('MEM')

Flight.create(
  arrival_airport: denver,
  departure_airport: memphis,
  start_datetime: Time.now + 2.days,
  duration: 60
)

Flight.create(
  arrival_airport: denver,
  departure_airport: memphis,
  start_datetime: Time.now + 1.days,
  duration: 45
)

Flight.create(
  arrival_airport: denver,
  departure_airport: memphis,
  start_datetime: Time.now + 6.months,
  duration: 45
)
