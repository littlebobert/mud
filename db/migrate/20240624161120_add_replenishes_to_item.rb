class AddReplenishesToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :replenishes, :bool, :default => false
  end
end
