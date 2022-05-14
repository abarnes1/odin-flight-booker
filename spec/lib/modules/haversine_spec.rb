# frozen_string_literal: true

require_relative '../../../app/lib/modules/haversine'

RSpec.describe Haversine do
  describe '#haversine_formula' do
    let(:kansas_city) { double('KansasCityAirport', latitude: 39.291832166, longitude: -94.7083305) }
    let(:orlando) { double('OrlandoAirport', latitude: 28.4311577, longitude: -81.308083) }

    it 'returns the correct distance' do
      expected_miles = 1072

      actual_miles = Haversine.haversine_formula(
                      kansas_city.latitude, 
                      kansas_city.longitude, 
                      orlando.latitude, 
                      orlando.longitude
                    ).round
      
      expect(actual_miles).to eq(expected_miles)
    end
  end
end