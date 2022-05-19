module FlightHelper
  def display_datetime(datetime)
    datetime.strftime("%m/%d/%Y %I:%M %p")
  end
end