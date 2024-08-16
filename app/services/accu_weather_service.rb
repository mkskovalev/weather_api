require 'net/http'
require 'json'

class AccuWeatherService
  API_KEY = Rails.application.credentials.accu_weather_api_key
  LOCATION_KEY = '294021'

  def self.update_weather_data
    url = "http://dataservice.accuweather.com/currentconditions/v1/#{LOCATION_KEY}?apikey=#{API_KEY}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    WeatherDatum.create(
      temperature: data.first['Temperature']['Metric']['Value'],
      recorded_at: Time.now
    )
  end
end
