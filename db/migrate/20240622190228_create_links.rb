class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.references :from, null: false, foreign_key: { to_table: :places }
      t.references :to, null: false, foreign_key: { to_table: :places }
      t.string :description

      t.timestamps
    end
  end
end
