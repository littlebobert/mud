class Item < ApplicationRecord
	belongs_to :place, optional: true
  belongs_to :user, optional: true
  has_many :quest_requirements, foreign_key: "requirement_id"
  has_many :quest_rewards, foreign_key: "reward_id"
end
