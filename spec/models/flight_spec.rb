require 'rails_helper'

RSpec.describe Flight, type: :model do
  fixtures :airports

  let(:orlando) { airports(:orlando) }
  let(:denver) { airports(:denver) }
  let(:cleveland) { airports(:cleveland) }
  let(:departure_datetime) { orlando.local_time.tomorrow.beginning_of_day + 8.hours }
  let(:flight) { create(:flight, departing: orlando, at: departure_datetime, arriving: denver) }

  context 'when trying to change departure airport attribute through association' do
    it 'is not persisted' do
      flight.departure_airport.name = cleveland.name
      flight.save
      flight.reload

      expect(flight.departure_airport).to eq(orlando)
    end
  end

  context 'when trying to change arrival airport attribute through association' do
    it 'is not persisted' do
      flight.arrival_airport.name = cleveland.name
      flight.save
      flight.reload

      expect(flight.departure_airport).to eq(orlando)
    end
  end
end
