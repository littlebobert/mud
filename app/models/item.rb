class Item < ApplicationRecord
	belongs_to :place, optional: true
  belongs_to :user, optional: true
end
