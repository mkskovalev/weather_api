require 'net/http'

class AccuWeatherService
  attr_reader :data

  def initialize(base_url)
    url = "#{base_url}#{location}?apikey=#{ ENV['ACCU_WEATHER_API_KEY'] }"
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    @data = JSON.parse(response.body)
  end

  def location
    '294021'
  end
end
