# frozen_string_literal: true

namespace :flights do
  # Seed today + [days] worth of flights, starting at [offset] days away.
  desc 'Add n days of flight data'
  task :add, %i[offset days] => :environment do |_task, args|
    number_of_days = [nil, '0'].include?(args[:days]) ? 1 : args[:days].to_i
    offset_days = args[:offset].nil? ? 0 : args[:offset].to_i

    puts "Adding #{number_of_days} day(s) worth of flights with #{offset_days} day(s) offset."

    start_date = Time.zone.now.to_date + offset_days.days

    date_range = if number_of_days.positive?
                   start_date...(start_date + number_of_days.days)
                 else
                   (start_date + number_of_days.days)...start_date
                 end

    puts "Effective date range: #{date_range.first} to #{date_range.last}."

    airports = Airport.all

    date_range.each do |date|
      airports.each do |departing|
        airports.each do |arriving|
          next if arriving == departing

          rand(0..3).times do
            depart_datetime = Time.zone.parse(date.to_s) + rand(1..23).hours + rand(1..59).minutes
            puts "Creating flight #{departing.code} to #{arriving.code} at #{depart_datetime}"
            FactoryBot.create(:flight, departing: departing, at: depart_datetime, arriving: arriving)
          end
        end
      end
    end
  end
end
