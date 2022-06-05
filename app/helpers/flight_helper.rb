module FlightHelper
  def display_time(time)
    time.strftime('%l:%M %p')
  end

  def display_duration(minutes)
    "#{minutes / 60} h #{minutes % 60} mins"
  end

  def display_departure_date(time)
    time.strftime('%a %b %-d, %Y')
  end
end
