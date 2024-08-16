require 'rails_helper'

RSpec.describe WeatherDatum, type: :model do
  it 'is valid with valid attributes' do
    weather_data = WeatherDatum.new(temperature: 25.5, recorded_at: Time.now)
    expect(weather_data).to be_valid
  end

  it 'is not valid without a temperature' do
    weather_data = WeatherDatum.new(recorded_at: Time.now)
    expect(weather_data).not_to be_valid
  end

  it 'is not valid without a recorded_at timestamp' do
    weather_data = WeatherDatum.new(temperature: 25.5)
    expect(weather_data).not_to be_valid
  end

  it 'saves the data correctly to the database' do
    weather_data = WeatherDatum.create(temperature: 25.5, recorded_at: Time.now)
    expect(WeatherDatum.find_by(temperature: 25.5)).to eq(weather_data)
  end
end
