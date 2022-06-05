class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.order(:code).map { |airport| [helpers.airport_select_value(airport), airport.id] }
    return unless valid_search?

    @search_results = search_flights(flight_search_params)
  end

  private

  def flight_search_params
    params.permit(:departure_airport_id, :arrival_airport_id, :departure_date, :passenger_count, :commit)
  end

  def valid_search?
    return false unless %i[departure_airport_id arrival_airport_id].all? { |key| params.include? key }

    if params[:departure_airport_id] == params[:arrival_airport_id]
      flash.now[:alert] = "From and To can't be the same."
      return false
    end

    true
  end

  def search_flights(params)
    flights = Flight.all

    flights = flights.where(departure_datetime: day_search_range)
    flights = flights.where(departure_airport_id: params[:departure_airport_id])
    flights = flights.where(arrival_airport_id: params[:arrival_airport_id])
    flights.where('departure_datetime > ?', Time.zone.now)
    flights.order(:departure_datetime)
  end

  def local_airport_time_to_utc
    airport = Airport.find_by_id(params[:departure_airport_id])
    airport_local_time = airport.local_time_zone.parse(params[:departure_date])
    airport_local_time.in_time_zone('UTC')
  end

  def day_search_range
    search_start = local_airport_time_to_utc
    search_start..(search_start + 1.days)
  end
end
