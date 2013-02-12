class LocationStatus < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :time, :accuracy

  scope :daytime, -> { where('time(convert_tz(time, "GMT", "America/Chicago")) BETWEEN ? AND ?', '07:00:00', '22:00:00') }
  scope :nighttime, -> { where('NOT time(convert_tz(time, "GMT", "America/Chicago")) BETWEEN ? AND ?', '07:00:00', '22:00:00') }

  scope :home, -> { where('(latitude BETWEEN (33.3099 - 0.01) AND (33.3099 + 0.01)) AND (longitude BETWEEN (-96.46 - 0.01) AND (-96.46 + 0.01))') }
  scope :not_home, -> { where('NOT (latitude BETWEEN (33.3099 - 0.01) AND (33.3099 + 0.01)) AND NOT (longitude BETWEEN (-96.46 - 0.01) AND (-96.46 + 0.01))') }

  def self.store_current_location
    location = Icloud.current_location

    status = self.where(time: DateTime.strptime("#{location[:timestamp]}", '%Q'),).first_or_create(
      latitude: location[:latitude],
      longitude: location[:longitude],
      accuracy: location[:accuracy])
    status.save
  end
end
