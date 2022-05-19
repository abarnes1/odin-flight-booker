class Airport < ApplicationRecord
  has_many :arriving_flights, class_name: 'Flight', foreign_key: 'arrival_airport_id'
  has_many :departing_flights, class_name: 'Flight', foreign_key: 'departure_airport_id'

  belongs_to :time_zone_info

  before_save :standardize_case

  default_scope { includes(:time_zone_info) }

  def local_time(time_with_zone = local_time_zone.now)
    time_with_zone.in_time_zone(local_time_zone)
  end

  def local_time_zone
    Time.find_zone(time_zone_info.rails_time_zone)
  end

  private

  def standardize_case
    code.upcase!
    self.name = name.split.each(&:capitalize).join(' ')
  end
end
