class CreateTimeZoneInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :time_zone_infos do |t|
      t.string :tzinfo_time_zone_name, null: false
      t.integer :base_utc_offset_hours, null: false
      t.timestamps
    end
  end
end
