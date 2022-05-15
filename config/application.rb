require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FlightBooker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Allows fixtures to be created with foreign key validation.
    # Prevents vague foreign key errors while loading fixtures when the
    # postgresql user for the test database lacks superuser permission required
    # to disable foreign key constraints.
    # config.active_record.verify_foreign_keys_for_fixtures = false
  end
end
