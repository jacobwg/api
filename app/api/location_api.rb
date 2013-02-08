class LocationApi < Grape::API

  version 'v1', :using => :path
  format :json

  resource :location do

    get do
      Icloud.current_location
    end

    get :history do
      LocationStatus.all
    end
  end

end