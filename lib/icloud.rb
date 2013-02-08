class Icloud

  def self.current_location
    @@r ||= Rosumi.new(ENV['ICLOUD_EMAIL'], ENV['ICLOUD_PASSWORD'])
    location = @@r.updateDevices.last['location']
    location = {
      latitude: location['latitude'],
      longitude: location['longitude'],
      accuracy: location['horizontalAccuracy'],
      timestamp: location['timeStamp']
    }
  end

end