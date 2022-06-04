require 'rails_helper'

RSpec.describe 'Flight Booking', type: :system do
  include ActionView::RecordIdentifier
  include AirportHelper
  include FlashHelper

  fixtures :time_zone_infos
  fixtures :airports

  context 'when filling in booking details' do
    let(:orlando) { airports(:orlando) }
    let(:denver) { airports(:denver) }
    let(:departure_datetime) { orlando.local_time.tomorrow.beginning_of_day + 8.hours }
    let(:flight) { create(:flight, departing: orlando, at: departure_datetime, arriving: denver) }

    before do
      visit new_booking_path(passenger_count: 2, flight_id: flight.id)
    end

    it 'saves the booking' do
      fill_in('booking_name', with: 'Booker Name')
      fill_in('booking_email', with: 'booker@newbooking.com')

      fill_in('booking_passengers_attributes_0_name', with: 'Passenger One')
      fill_in('booking_passengers_attributes_0_email', with: 'one@newbooking.com')

      fill_in('booking_passengers_attributes_1_name', with: 'Passenger Two')
      fill_in('booking_passengers_attributes_1_email', with: 'two@newbooking.com')

      click_on 'Book Flight'

      expect(page).to have_content(booking_success_message)
    end
  end
end
