class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.references :character, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.references :requirement, null: false, foreign_key: { to_table: :items }
      t.references :reward, null: false, foreign_key: { to_table: :items }

      t.timestamps
    end
  end
end
