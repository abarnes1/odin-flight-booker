require 'rails_helper'
# require_relative '../support/chrome'

RSpec.describe 'Flight Search', type: :system do
  fixtures :time_zone_infos
  fixtures :airports

  context 'when searching flights' do
    let(:orlando) { airports(:orlando) }
    let(:denver) { airports(:denver) }
    let(:cleveland) { airports(:cleveland) }

    let(:departure_datetime) { orlando.local_time.tomorrow.beginning_of_day + 8.hours }

    # use let! or it won't ever be created... doh!
    let!(:valid_flight) { create(:flight, departing: orlando, at: departure_datetime, arriving: denver) }

    before do
      visit flights_path
    end

    it 'returns only valid' do
      find_by_id('departure_airport_id').find("option[value='#{orlando.id}']").click
      find_by_id('arrival_airport_id').find("option[value='#{denver.id}']").click
      fill_in('departure_date', with: orlando.local_time_zone.tomorrow)

      click_on 'Search'

      page.driver.browser.manage.window.resize_to(1600, 1200)
      page.save_screenshot

      puts "looking for... #{summary(valid_flight)}"

      expect(page).to have_content(summary(valid_flight))
    end

    # it 'fails' do
    #   expect(false).to be false
    # end
  end
end
