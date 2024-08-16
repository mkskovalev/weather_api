class WeatherDatum < ApplicationRecord
  validates :temperature, :recorded_at, presence: true
end
