class BeermappingApi
  def self.places_in(city)
    city = city.downcase

    # gets caught by places.empty?
    # TODO fix error message, No locations in ""
    return "" if city == ""

    Rails.cache.fetch(city, expires_in: 1.week) { get_places_in city }
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    places = response.parsed_response["bmp_locations"]["location"]
    return [] if places.is_a?(Hash) && places["id"].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.key
    return nil if Rails.env.test?
    key = Rails.application.credentials.beermapping_api_key
    raise 'BEERMAPPING_API_KEY env variable not defined' if key.nil?
    return key
  end
end
