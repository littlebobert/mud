class Character < ApplicationRecord
  belongs_to :place, optional: true
  has_many :messages
end