class AddAreaAndOutdoorsToPlace < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :area, :string, :default => "Meguro"
    add_column :places, :outdoors, :bool, :default => false
  end
end
