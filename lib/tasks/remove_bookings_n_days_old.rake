namespace :bookings do
  desc 'Remove bookings at least n days old.'
  task :remove, [:days] => :environment do |_task, args|
    days = args[:days].nil? ? 7 : args[:days].to_i
    puts "Removing bookings older than #{days}."

    start_date = Time.zone.now.to_date

    dates = if days.positive?
      start_date..(start_date + days.days)
    else
      (start_date + days.days)..start_date
    end

    Flight.where(departure_datetime: dates).left_outer_joins(:bookings).where(bookings: { id: nil }).order(:id).each do |flight|
      puts "Removing flight id #{flight.id}"
    end
  end
end