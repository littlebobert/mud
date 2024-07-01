class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[apple]
         
         
  has_many :messages
  has_many :items
  belongs_to :place, optional: true
  has_many :quest_logs
  
  validates :name, presence: true, uniqueness: true
  
  ACTIVITIES = { 
    browse_hacker_news: { do_it: "browse hacker news on your phone", doing_it: "browsing hacker news on their phone" }
  }
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.skip_confirmation! if user.respond_to?(:skip_confirmation)
    end
  end
end
