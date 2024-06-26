class FetchWeatherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    WeatherReport::AREAS.each do |area, lat_long|
      weather_blob = WeatherService.new(lat_long[:lat], lat_long[:long]).call
      weather_report = WeatherReport.new(area: area, temp: weather_blob[:temp], units: "metric", description: weather_blob[:description])
      if weather_report.save
        puts "saved weather report successfully"
      else
        puts "there was an error saving a weather report: #{weather_report.errors.full_messages}"
      end
    end
  end
end
