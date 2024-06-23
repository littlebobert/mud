class AddFromUserToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :from_user, :bool, :default => false
  end
end
