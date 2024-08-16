class UpdateWeatherDataJob < ApplicationJob
  queue_as :default

  def perform
    AccuWeatherService.update_weather_data
  end
end