class Place < ApplicationRecord
	has_many :outgoing_links, :class_name => 'Link', :foreign_key => 'from_id'
	has_many :incoming_links, :class_name => 'Link', :foreign_key => 'to_id'
  has_many :exits, through: :outgoing_links, source: :to
  has_many :entrances, through: :incoming_links, source: :from
  has_many :items
  has_many :characters
  has_many :users
end
