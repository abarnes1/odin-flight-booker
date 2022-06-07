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

      expect { flight.departure_airport.save }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end

  context 'when trying to change arrival airport attribute through association' do
    it 'is raises a read only error' do
      flight.arrival_airport.name = cleveland.name

      expect { flight.arrival_airport.save }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end
end
