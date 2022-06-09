# frozen_string_literal: true

namespace :flights do
  desc 'Remove flights at least n days old.'
  task :remove, %i[offset days] => :environment do |_task, args|
    number_of_days = [nil, '0'].include?(args[:days]) ? 1 : args[:days].to_i
    offset_days = args[:offset].nil? ? 0 : args[:offset].to_i

    puts "Removing #{number_of_days} day(s) worth of flights with #{offset_days} day(s) offset."

    start_date = Time.zone.now.to_date + offset_days.days

    date_range = if number_of_days.positive?
                   start_date...(start_date + number_of_days.days)
                 else
                   (start_date + number_of_days.days)...start_date
                 end

    puts "Effective date range: #{date_range.first} to #{date_range.last}."

    removed_count = Flight.where(departure_datetime: date_range).destroy_all.count

    puts "#{removed_count} flights removed."
  end
end
