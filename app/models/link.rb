class Link < ApplicationRecord
  belongs_to :from, :class_name => "Place"
  belongs_to :to, :class_name => "Place"
end
