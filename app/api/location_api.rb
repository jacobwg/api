class LocationApi < Grape::API

  version 'v1', :using => :path
  format :json

  resource :location do

    get do
      Icloud.current_location
    end

    get :history do
      results = LocationStatus

      results = results.daytime if params[:daytime]
      results = results.nighttime if params[:nighttime]
      results = results.home if params[:home]
      results = results.not_home if params[:not_home]

      results.all
    end
  end

end