class Character < ApplicationRecord
  belongs_to :place, optional: true
  has_many :messages
  has_many :quests
  has_many :quest_logs, through: :quests
  belongs_to :item, optional: true
end
