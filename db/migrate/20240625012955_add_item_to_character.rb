class AddItemToCharacter < ActiveRecord::Migration[7.1]
  def change
    add_reference :characters, :item, null: true, foreign_key: true
  end
end
