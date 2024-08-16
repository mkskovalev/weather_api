class CreateWeatherData < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_data do |t|
      t.float :temperature, null: false
      t.datetime :recorded_at, null: false

      t.timestamps
    end
  end
end
