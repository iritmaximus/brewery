class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city_search] = params[:city]
      render :index, status: 418
    end
  end

  def show
    places = BeermappingApi.places_in(session[:last_city_search])
    @place = places.select { |place| place.id == params[:id] }[0]
  end
end
