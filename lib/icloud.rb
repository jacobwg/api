class Icloud

  def self.current_location
    @@r ||= Rosumi.new(ENV['ICLOUD_EMAIL'], ENV['ICLOUD_PASSWORD'])
    @@r.updateDevices.last['location']
  end

end