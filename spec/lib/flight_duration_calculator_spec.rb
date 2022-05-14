# frozen_string_literal: true

require_relative '../../app/lib/flight_duration_calculator'

RSpec.describe FlightDurationCalculator do
  describe '#flight_minutes' do
    let(:kansas_city) { double('KansasCityAirport', latitude: 39.291832166, longitude: -94.7083305) }
    let(:orlando) { double('OrlandoAirport', latitude: 28.4311577, longitude: -81.308083) }

    it 'returns the correct minutes' do
      expected_minutes = 184

      air_speed_mph = 350
      actual_minutes = FlightDurationCalculator.flight_minutes(kansas_city, orlando, air_speed_mph)

      expect(actual_minutes).to eq(expected_minutes)
    end
  end
end
