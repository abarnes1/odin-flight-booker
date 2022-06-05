module FlightHelper
  def display_datetime(datetime)
    datetime.strftime('%m/%d/%Y %I:%M %p')
  end

  def flight_summary(flight)
    "#{flight.departure_airport.code} #{display_datetime(flight.local_departure_time)} -> " \
    "#{flight.arrival_airport.code} #{display_datetime(flight.local_arrival_time)}" \
    " (#{flight.duration} minutes)."
  end

  def display_time(time)
    time.strftime("%l:%M %p")
  end

  def display_duration(minutes)
    "#{minutes / 60} h #{minutes % 60} mins"
  end

  def display_departure_date(time)
    time.strftime("%a %b %-d, %Y")
  end
end
