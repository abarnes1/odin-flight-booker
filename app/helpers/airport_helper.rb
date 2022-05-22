module AirportHelper
  def airport_select_value(airport)
    "#{airport.code} (#{airport.name})"
  end
end