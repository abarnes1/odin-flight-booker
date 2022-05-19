module FlightHelper
  def display_datetime(datetime)
    datetime.strftime("%m/%d/%Y %I:%M %p")
  end

  def summary(flight)
    "#{flight.departure_airport.code} #{display_datetime(flight.local_departure_time)} -> " +
    "#{flight.arrival_airport.code} #{display_datetime(flight.local_arrival_time)}" +
    "(#{flight.duration} minutes)."
  end
end