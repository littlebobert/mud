class AddPlaceToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :place, null: true, foreign_key: true
  end
end
