class AddItemsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :user, null: true, foreign_key: true
  end
end
