class LocationApi < Grape::API

  version 'v1', :using => :path
  format :json

  resource :location do

    get do
      @R ||= Rosumi.new(ENV['ICLOUD_EMAIL'], ENV['ICLOUD_PASSWORD'])
      @R.updateDevices.last['location'].to_json
    end

    get :history do
      (1..10).to_a
    end
  end

end