# frozen_string_literal: true

namespace :bookings do
  desc 'Add n days of flight data'
  task :add, %i[offset days] => :environment do |_task, args|
    number_of_days = [nil, '0'].include?(args[:days]) ? 1 : args[:days].to_i
    offset_days = args[:offset].nil? ? 0 : args[:offset].to_i

    puts "Adding bookings for #{number_of_days} day(s) worth of flights with #{offset_days} day(s) offset."

    start_date = Time.zone.now.to_date + offset_days.days

    date_range = if number_of_days.positive?
                   start_date..(start_date + number_of_days.days)
                 else
                   (start_date + number_of_days.days)..start_date
                 end

    puts "Effective date range: #{date_range.first} to #{date_range.last}."

    flights = Flight.where(departure_datetime: date_range)

    flights.each do |flight|
      passengers = rand(0..4)
      puts "Creating #{passengers} bookings for flight id #{flight.id}"
      FactoryBot.create(:booking_with_passengers, flight: flight, passenger_count: passengers) unless passengers.zero?
    end
  end
end
