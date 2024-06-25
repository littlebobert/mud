class AddOneShotToQuest < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :one_shot, :bool, :default => false
  end
end
