class Place < OpenStruct
  def self.rendered_fields
    [:id, :name, :status, :street, :city, :zip, :country, :overall]
  end

  def self.weather(location)
    weather_api_key = api_key
    weather_api_url = "http://api.weatherstack.com/current"

    response = HTTParty.get "#{weather_api_url}?access_key=#{weather_api_key}&query=#{location}"

    puts "#{weather_api_url}?access_key=#{weather_api_key}&query=#{location}"
    puts response.parsed_response
    data = response.parsed_response["current"]
    if data.nil?
      return
    end

    parse_weather_data data
  end

  def self.parse_weather_data(data)
    temperature = data["temperature"]
    weather_icon = data["weather_icons"][0]
    weather_descriptions = data["weather_descriptions"][0]
    weather_icon = { image: weather_icon, description: weather_descriptions }
    wind_direction = data["wind_dir"]
    wind_speed = data["wind_speed"]
    wind = { direction: wind_direction, speed: wind_speed }
    { temperature:, wind:, weather_icon: }
  end

  def self.api_key
    return nil if Rails.env.test?

    key = Rails.application.credentials.weatherstack_api_key
    raise 'WEATHERSTACK_API_KEY env variable not defined in credentials' if key.nil?

    key
  end
end
