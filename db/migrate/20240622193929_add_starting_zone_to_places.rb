class AddStartingZoneToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :starting_zone, :bool, :default => false
  end
end
