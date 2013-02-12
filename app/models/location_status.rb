class LocationStatus < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :time, :accuracy

  scope :daytime, -> { where('time(convert_tz(time, "GMT", "America/Chicago")) BETWEEN ? AND ?', '07:00:00', '22:00:00') }
  scope :nighttime, -> { where('NOT time(convert_tz(time, "GMT", "America/Chicago")) BETWEEN ? AND ?', '07:00:00', '22:00:00') }

  def self.store_current_location
    location = Icloud.current_location

    status = self.where(time: DateTime.strptime("#{location[:timestamp]}", '%Q'),).first_or_create(
      latitude: location[:latitude],
      longitude: location[:longitude],
      accuracy: location[:accuracy])
    status.save
  end
end
