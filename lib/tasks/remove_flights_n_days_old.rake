namespace :flights do
  desc 'Remove flights at least n days old that have no bookings.'
  task :remove, [:days] => :environment do |_task, args|
    days = args[:days].nil? ? 7 : args[:days].to_i
    puts "Removing flights older than #{days} with no bookings."

    start_date = Time.zone.now.to_date

    dates = if days.positive?
      start_date..(start_date + days.days)
    else
      (start_date + days.days)..start_date
    end

    Flight.left_outer_joins(:bookings).where(bookings: { id: nil }).destroy_all
  end
end
