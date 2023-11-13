class PlacesController < ApplicationController
  def index
  end

  def search
    if params[:city] == ""
      redirect_to places_path, notice: "No place provided"
      return
    end

    api_key = Rails.application.credentials.beermap_api_key
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(params[:city])}"

    places_from_api = response.parsed_response["bmp_locations"]["location"]
    puts places_from_api

    # sometimes the response is:  {"id"=>"0", "name"=>"No locations Found", "status"=>nil, "reviewlink"=>nil, "proxylink"=>nil, "blogmap"=>nil, "street"=>nil, "city"=>nil, "state"=>nil, "zip"=>nil, "country"=>nil, "phone"=>nil, "url"=>nil, "overall"=>nil, "imagecount"=>nil}
    # but sometimes:              {"id"=>nil, "name"=>nil, "status"=>nil, "reviewlink"=>nil, "proxylink"=>nil, "blogmap"=>nil, "street"=>nil, "city"=>nil, "state"=>nil, "zip"=>nil, "country"=>nil, "phone"=>nil, "url"=>nil, "overall"=>nil, "imagecount"=>nil}
    if places_from_api.is_a?(Hash) && places_from_api['id'].nil?
      redirect_to places_path, notice: "No places in #{params[:city]}"
      return
    else
      places_from_api = [places_from_api] if places_from_api.is_a?(Hash)
      @places = places_from_api.map do |location|
        Place.new(location)
      end
      render :index, status: 418
    end

  end
end
