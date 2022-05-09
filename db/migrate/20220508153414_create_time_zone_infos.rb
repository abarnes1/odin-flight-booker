class CreateTimeZoneInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :time_zone_infos do |t|
      # The TimeZone class in Rails's ActiveSupport wraps the TZInfo gem with friendlier names
      # https://github.com/rails/rails/blob/f95c0b7e96eb36bc3efc0c5beffbb9e84ea664e4/activesupport/lib/active_support/values/time_zone.rb#L29
      t.string :rails_time_zone, null: false

      # The TZInfo gem uses IANA timezone names
      # TZInfo: https://github.com/tzinfo/tzinfo/blob/8d87a69eaf39e8fcfbac5550003ffc8763b5c1dd/test/tzinfo-data1/tzinfo/data/indexes/timezones.rb
      # IANA: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
      t.string :iana_time_zone, null: false

      # Store the offsets if for some reason either Rails's wrapper or IANA were no longer usable
      t.integer :standard_utc_offset_hours, null: false
      t.integer :daylight_savings_utc_offset_hours, null: false
      t.timestamps
    end
  end
end

# https://github.com/rails/rails/blob/f95c0b7e96eb36bc3efc0c5beffbb9e84ea664e4/activesupport/lib/active_support/values/time_zone.rb#L29
