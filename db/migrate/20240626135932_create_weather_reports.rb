class CreateWeatherReports < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_reports do |t|
      t.string :area
      t.float :temp
      t.string :units
      t.string :description

      t.timestamps
    end
  end
end
