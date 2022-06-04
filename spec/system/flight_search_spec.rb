require 'rails_helper'
# require_relative '../support/chrome'

RSpec.describe 'Flight Search', type: :system do
  include ActionView::RecordIdentifier
  include AirportHelper
  include FlashHelper

  fixtures :time_zone_infos
  fixtures :airports

  context 'when searching flights' do
    let(:orlando) { airports(:orlando) }
    let(:denver) { airports(:denver) }
    let(:cleveland) { airports(:cleveland) }

    before do
      visit flights_path

      select(airport_select_value(orlando), from: 'departure_airport_id')
      select(airport_select_value(denver), from: 'arrival_airport_id')
    end

    it 'finds matching flights' do
      departure_datetime = orlando.local_time.tomorrow.beginning_of_day + 8.hours
      matching_flight = create(:flight, departing: orlando, at: departure_datetime, arriving: denver)

      fill_in('departure_date', with: orlando.local_time_zone.tomorrow)

      click_on 'Search'

      expect(page).to have_selector(:id, dom_id(matching_flight))
    end

    it 'does not find non-matching flights' do
      departure_datetime = orlando.local_time.tomorrow.beginning_of_day + 8.hours
      not_matching_flight = create(:flight, departing: orlando, at: departure_datetime, arriving: cleveland)

      fill_in('departure_date', with: orlando.local_time_zone.tomorrow)

      click_on 'Search'

      expect(page).to_not have_selector(:id, dom_id(not_matching_flight))
    end

    it 'does not find past flights' do
      departure_datetime = orlando.local_time - 1.seconds
      past_flight = create(:flight, departing: orlando, at: departure_datetime, arriving: denver)

      fill_in('departure_date', with: orlando.local_time_zone.today)

      click_on 'Search'

      expect(page).not_to have_selector(:id, dom_id(past_flight))
    end
  end

  context 'when selecting a flight to book' do
    let(:orlando) { airports(:orlando) }
    let(:denver) { airports(:denver) }

    before do
      visit flights_path
    end

    it 'redirects to the flight booking page' do
      departure_datetime = orlando.local_time.tomorrow.beginning_of_day + 8.hours
      matching_flight = create(:flight, departing: orlando, at: departure_datetime, arriving: denver)

      select(airport_select_value(orlando), from: 'departure_airport_id')
      select(airport_select_value(denver), from: 'arrival_airport_id')
      select('2', from: 'passenger_count')
      fill_in('departure_date', with: orlando.local_time_zone.tomorrow)

      click_on 'Search'

      choose(dom_id(matching_flight))

      click_on 'Book Flight'

      expect(find('h1')).to have_content('Flight Booking Details')
    end
  end

  context 'when departing and arriving airport are the same' do
    let(:orlando) { airports(:orlando) }

    before do
      visit flights_path
    end

    it 'displays an error message' do
      select(airport_select_value(orlando), from: 'departure_airport_id')
      select(airport_select_value(orlando), from: 'arrival_airport_id')

      fill_in('departure_date', with: orlando.local_time_zone.today)

      click_on 'Search'

      expect(page).to have_content(matching_airports_error)
    end
  end
end
