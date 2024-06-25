class AddOnlySpeaksJapaneseToCharacter < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :only_speaks_japanese, :bool, :default => false
  end
end
