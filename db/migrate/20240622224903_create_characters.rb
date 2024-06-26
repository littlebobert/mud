class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :place, foreign_key: true
      t.timestamps
    end
  end
end
