class AddActivityToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :activity, :string
  end
end
