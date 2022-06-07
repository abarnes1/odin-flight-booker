require 'rails_helper'

RSpec.describe Booking, type: :model do
  fixtures :airports

  let(:orlando) { airports(:orlando) }
  let(:denver) { airports(:denver) }
  let(:cleveland) { airports(:cleveland) }
  let(:departure_datetime) { orlando.local_time.tomorrow.beginning_of_day + 8.hours }
  let(:flight) { create(:flight, departing: orlando, at: departure_datetime, arriving: denver) }
  let(:booking) { create(:booking, flight: flight) }

  context 'when trying to change flight attribute through association' do
    it 'is not persisted' do
      booking.flight.duration = 1000

      expect { booking.flight.save }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end
end
