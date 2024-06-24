class CreateQuestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quest, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
