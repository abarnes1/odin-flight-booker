# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Airport.create(
  [
    { code: 'MEM', name: 'Memphis' },
    { code: 'DEN', name: 'Denver' },
    { code: 'MKE', name: 'Milwaukee' },
    { code: 'DFW', name: 'Dallas - Fort Worth' },
    { code: 'CLE', name: 'Cleveland' },
    { code: 'MCI', name: 'Kansas City' },
    { code: 'MCO', name: 'Orlando' },
    { code: 'ANC', name: 'Anchorage' },
    { code: 'LAX', name: 'Los Angeles' },
    { code: 'LIT', name: 'Little Rock' }
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
