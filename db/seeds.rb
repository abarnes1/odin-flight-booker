# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Airport.create(
  [
    { code: 'MKE', name: 'Milwaukee' },
    { code: 'DFW', name: 'Dallas/Fort Worth' },
    { code: 'MEM', name: 'Memphis' },
    { code: 'CLE', name: 'Cleveland' },
    { code: 'MCI', name: 'Kansas City' },
    { code: 'MCO', name: 'Orlando' },
    { code: 'ANC', name: 'Anchorage' },
    { code: 'LAX', name: 'Los Angeles' },
    { code: 'LIT', name: 'Little Rock' },
    { code: 'DEN', name: 'Denver' }
  ]
)
