require 'rails_helper'
# require_relative '../support/chrome'

RSpec.describe 'Flight Search', type: :system do
  fixtures :time_zone_infos
  fixtures :airports

  context 'placeholder' do
    it 'passes' do
      expect(true).to be true
    end

    it 'fails' do
      expect(false).to be false
    end
  end
end
