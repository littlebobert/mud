require 'http'
require 'json'

class WeatherService
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def call
    exclude = "minutely,hourly,daily,alerts"
    key = ENV["OPEN_WEATHER_API_KEY"]
    url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{@lat}&lon=#{@long}&exclude=#{exclude}&appid=#{key}&units=metric"
    headers = {
      'Content-Type' => 'application/json'
    }
    response = HTTP.headers(headers).get(url)
    response_data = JSON.parse(response.body.to_s)
    temp = response_data["current"]["temp"]
    description = response_data["current"]["weather"].first["description"]
    return { temp: temp, description: description }
  end
end