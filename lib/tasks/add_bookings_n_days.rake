namespace :bookings do
  desc 'Add n days of flight data'
  task :add, [:days] => :environment do |_task, args|
    days = args[:days].nil? ? 7 : args[:days].to_i

    puts "Seeding bookings for #{days} day(s) worth of flights."

    start_date = Time.zone.now.to_date

    dates = if days.positive?
              start_date..(start_date + days.days)
            else
              (start_date + days.days)..start_date
            end

    flights = Flight.where(departure_datetime: dates)

    flights.each do |flight|
      passengers = rand(0..4)
      puts "Creating #{passengers} bookings for flight id #{flight.id}"
      FactoryBot.create(:booking_with_passengers, flight: flight, passenger_count: passengers) unless passengers.zero?
    end
  end
end
