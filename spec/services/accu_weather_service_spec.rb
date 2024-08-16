require 'rails_helper'

RSpec.describe AccuWeatherService do
  describe '.update_weather_data', :vcr do
    it 'fetches and saves current weather data' do
      expect {
        AccuWeatherService.update_weather_data
      }.to change { WeatherDatum.count }.by(1)
    end
  end
end
