class Quest < ApplicationRecord
  belongs_to :character
  belongs_to :requirement, class_name: 'Item'
  belongs_to :reward, class_name: 'Item'
  has_many :quest_logs
end
