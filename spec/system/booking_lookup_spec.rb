require 'rails_helper'

RSpec.describe 'Booking Lookup', type: :system do
  include ActionView::RecordIdentifier
  include AirportHelper
  include FlashHelper

  fixtures :time_zone_infos
  fixtures :airports

  context 'when booking is found' do
    let(:orlando) { airports(:orlando) }
    let(:denver) { airports(:denver) }
    let(:departure_datetime) { orlando.local_time.tomorrow.beginning_of_day + 8.hours }
    let(:flight) { create(:flight, departing: orlando, at: departure_datetime, arriving: denver) }
    let(:booking) { create(:booking_with_passengers, flight: flight) }

    before do
      visit bookings_path
    end

    it 'redirects to the booking details page' do
      fill_in('booking_confirmation_code', with: booking.confirmation_code)
      fill_in('booking_email', with: booking.email)

      click_on 'Search'

      expect(page).to have_content(booking.name)
    end
  end

  context 'when booking is not found' do
    before do
      visit bookings_path
    end

    it 'displays the booking not found message' do
      fill_in('booking_confirmation_code', with: 'DOES NOT MATTER')
      fill_in('booking_email', with: 'name@domain.com')

      click_on 'Search'

      expect(page).to have_content(booking_not_found_message)
    end
  end
end
