class Item < ApplicationRecord
	belongs_to :place, optional: true
end
