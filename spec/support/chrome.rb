# Allow headless tests

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by ENV['SHOW_BROWSER'] ? :selenium_chrome : :selenium_chrome_headless
    # driven_by :rack_test
  end
end
