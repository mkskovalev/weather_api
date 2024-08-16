module WeatherApi
  class API < Grape::API
    format :json

    resource :weather do
      desc 'Get current temperature'
      get :current do
        weather_data = WeatherDatum.order(recorded_at: :desc).first
        if weather_data
          { temperature: weather_data.temperature, recorded_at: weather_data.recorded_at }
        else
          error!('No data available', 404)
        end
      end

      desc 'Get historical temperature data for the last 24 hours'
      get :historical do
        WeatherDatum.where('recorded_at >= ?', 24.hours.ago)
      end

      desc 'Get max temperature for the last 24 hours'
      get 'historical/max' do
        WeatherDatum.where('recorded_at >= ?', 24.hours.ago).maximum(:temperature)
      end

      desc 'Get min temperature for the last 24 hours'
      get 'historical/min' do
        WeatherDatum.where('recorded_at >= ?', 24.hours.ago).minimum(:temperature)
      end

      desc 'Get avg temperature for the last 24 hours'
      get 'historical/avg' do
        WeatherDatum.where('recorded_at >= ?', 24.hours.ago).average(:temperature)
      end

      desc 'Get temperature closest to a given timestamp'
      params do
        requires :timestamp, type: Integer, desc: 'Unix timestamp'
      end
      get 'by_time' do
        target_time = Time.at(params[:timestamp].to_i)
        search_period = 86400 # 1 день = 86400 секунд
      
        weather_data = WeatherDatum.all
      
        closest_weather_data = weather_data.min_by { |record| (record.recorded_at.to_i - target_time.to_i).abs }
      
        if closest_weather_data
          time_difference = (closest_weather_data.recorded_at.to_i - target_time.to_i).abs
      
          # Проверяем, находится ли разница в пределах, например, одного дня
          if time_difference <= search_period
            { temperature: closest_weather_data.temperature, recorded_at: closest_weather_data.recorded_at }
          else
            error!('No data available', 404)
          end
        else
          error!('No data available', 404)
        end
      end
    end

    resource :health do
      desc 'Check API health'
      get do
        { status: 'OK' }
      end
    end

    add_swagger_documentation(
      info: {
        title: 'Weather API',
        description: 'API для получения данных о погоде',
        contact_name: 'Your Name',
        contact_email: 'your.email@example.com'
      },
      api_version: 'v1',
      hide_documentation_path: false,
      mount_path: '/swagger_doc',
      hide_format: true
    )
  end
end
