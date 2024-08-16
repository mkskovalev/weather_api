RSpec.describe 'Weather API', type: :request do
  describe 'GET /weather/current', :vcr do
    it 'returns the current temperature' do
      WeatherDatum.create(temperature: 25.5, recorded_at: Time.now)

      get '/weather/current'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('temperature' => 25.5)
    end
  end

  describe 'GET /weather/historical', :vcr do
    it 'returns hourly temperatures for the last 24 hours' do
      24.times do |i|
        WeatherDatum.create(temperature: 20 + i, recorded_at: i.hours.ago)
      end

      get '/weather/historical'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(24)
    end
  end

  describe 'GET /weather/historical/max', :vcr do
    it 'returns the maximum temperature in the last 24 hours' do
      WeatherDatum.create(temperature: 30, recorded_at: 1.hour.ago)
      WeatherDatum.create(temperature: 25, recorded_at: 2.hours.ago)

      get '/weather/historical/max'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(30)
    end
  end

  describe 'GET /weather/historical/min', :vcr do
    it 'returns the minimum temperature in the last 24 hours' do
      WeatherDatum.create(temperature: 15, recorded_at: 1.hour.ago)
      WeatherDatum.create(temperature: 20, recorded_at: 2.hours.ago)

      get '/weather/historical/min'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(15)
    end
  end

  describe 'GET /weather/historical/avg', :vcr do
    it 'returns the average temperature in the last 24 hours' do
      WeatherDatum.create(temperature: 15, recorded_at: 1.hour.ago)
      WeatherDatum.create(temperature: 25, recorded_at: 2.hours.ago)

      get '/weather/historical/avg'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(20.0)
    end
  end

  describe 'GET /weather/by_time', :vcr do
    it 'returns the temperature closest to the given timestamp' do
      target_time = 1.hour.ago
      WeatherDatum.create(temperature: 20, recorded_at: target_time)
      WeatherDatum.create(temperature: 25, recorded_at: 2.hours.ago)

      get '/weather/by_time', params: { timestamp: target_time.to_i }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('temperature' => 20)
    end

    it 'returns 404 if no data is close enough to the given timestamp' do
      WeatherDatum.create(temperature: 25, recorded_at: 2.hours.ago)

      get '/weather/by_time', params: { timestamp: 1.year.ago.to_i }

      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /health' do
    it 'returns OK' do
      get '/health'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('status' => 'OK')
    end
  end
end
