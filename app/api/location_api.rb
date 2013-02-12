class LocationApi < Grape::API

  version 'v1', :using => :path
  format :json

  resource :location do

    get do
      Icloud.current_location
    end

    get :history do
      results = LocationStatus

      results = results.daytime if params[:daytime] == 'true'
      results = results.nighttime if params[:daytime] == 'false'
      results = results.home if params[:home] == 'true'
      results = results.not_home if params[:home] == 'false'

      results.all
    end
  end

end