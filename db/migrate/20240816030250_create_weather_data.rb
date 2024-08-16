class CreateWeatherData < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_data do |t|
      t.float :temperature
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
