class LocationStatus < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :time, :accuracy

  def self.store_current_location
    location = Icloud.current_location

    status = self.where(time: DateTime.strptime("#{location['timestamp']}", '%Q'),).first_or_create(
      latitude: location['latitude'],
      longitude: location['longitude'],
      accuracy: location['horizontalAccuracy'])
    status.save
  end
end
