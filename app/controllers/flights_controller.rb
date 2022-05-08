class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.order(:code).map { |airport| ["#{airport.code} (#{airport.name})", airport.id] }

    @flight_search_results = search_flights(params)
  end

  private

  def search_flights(params)
    flights = Flight.all
    flights = flights.where('start_datetime >= ?', Time.now) if params[:start_date].present?
    flights = flights.where(departure_airport_id: params[:departure_airport_id]) if params[:departure_airport_id].present?
    flights = flights.where(arrival_airport_id: params[:arrival_airport_id]) if params[:arrival_airport_id].present?

    flights
  end
end