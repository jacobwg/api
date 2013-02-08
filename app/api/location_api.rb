class LocationApi < Grape::API

  version 'v1', :using => :path
  format :json

  resource :location do

    get do
      (1..12).to_a
    end

    get :all do
      (1..10).to_a
    end
  end

end