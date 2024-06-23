class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
  has_many :messages
  has_many :items
  belongs_to :place, optional: true
  
  validates :name, presence: true, uniqueness: true
  
  ACTIVITIES = { 
    browse_hacker_news: { do_it: "browse hacker news", doing_it: "browsing hacker news" }
  }
end
