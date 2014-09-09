class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, omniauth_providers: [:github]
         
  validates :name, presence: true       
  
  has_many :recipes
  has_many :comments
  has_many :meal_plans
  has_many :cookbooks
  
  def self.from_omniauth(auth)
    y auth
    
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email || "no@email." + auth.provider
        
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        user.username = auth.info.nickname   # assuming the user model has a name
        user.picture = auth.info.image
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["omniauth.auth"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
