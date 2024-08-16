require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1h' do
  AccuWeatherService.update_weather_data
end
