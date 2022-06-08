namespace :flights do
  desc 'Add n days of flight data'
  task :add, [:days] => :environment do |_task, args|
    days = args[:days].nil? ? 7 : args[:days].to_i

    puts "Seeding #{days} day(s) worth of flights."

    start_date = Time.zone.now.to_date

    dates = if days.positive?
              start_date..(start_date + days.days)
            else
              (start_date + days.days)..start_date
            end

    airports = Airport.all

    dates.each do |date|
      airports.each do |departing|
        airports.each do |arriving|
          next if arriving == departing

          rand(0..3).times do
            depart_datetime = Time.zone.parse(date.to_s) + rand(1..23).hours + rand(1..59).minutes
            puts "Creating #{departing.code} to #{arriving.code} on #{depart_datetime}"
            FactoryBot.create(:flight, departing: departing, at: depart_datetime, arriving: arriving)
          end
        end
      end
    end
  end
end
