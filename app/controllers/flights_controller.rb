class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.order(:code).map { |airport| ["#{airport.code} (#{airport.name})", airport.id] }
    return if flight_search_params.empty?

    @search_results = search_flights(flight_search_params)
  end

  private

  def flight_search_params
    params.permit(:departure_airport_id, :arrival_airport_id, :departure_date, :passenger_count)
  end

  def search_flights(params)
    flights = Flight.all

    if params[:departure_date].present?
      search_start = local_airport_time_to_utc
      search_range = search_start..(search_start + 1.days)

      flights = flights.where(departure_datetime: search_range)
    end

    flights = flights.where(departure_airport_id: params[:departure_airport_id]) if params[:departure_airport_id].present?
    flights = flights.where(arrival_airport_id: params[:arrival_airport_id]) if params[:arrival_airport_id].present?

    flights
  end

  def local_airport_time_to_utc
    airport = Airport.find_by_id(params[:departure_airport_id])
    airport_local_time = airport.local_time_zone.parse(params[:departure_date])
    airport_local_time.in_time_zone('UTC')
  end
end
