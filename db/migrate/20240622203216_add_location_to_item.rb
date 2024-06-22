class AddLocationToItem < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :place, null: true, foreign_key: true
  end
end
