require_relative '../../lib/flight_duration_calculator'

FactoryBot.define do
  factory :flight do
    transient do
      departing { nil }
      arriving { nil }
      at { departing.local_time + 1.hours }
    end

    departure_airport_id { departing.id }
    arrival_airport_id { arriving.id }
    departure_datetime { at }

    duration { FlightDurationCalculator.flight_minutes(departing, arriving) }
  end
end
