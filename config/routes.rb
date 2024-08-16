require_relative '../app/api/weather_api'

Rails.application.routes.draw do
  mount WeatherApi::API => '/'
end
