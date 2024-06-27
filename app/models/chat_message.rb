class ChatMessage < ApplicationRecord
  belongs_to :place
  belongs_to :user
end
