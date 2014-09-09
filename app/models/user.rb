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
    where(provider: auth.provider, id: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        password = Devise.friendly_token[0,20]
        user.password = password
        user.password_confirmation = password
        user.name = auth.info.name   # assuming the user model has a name
        user.username = auth.info.nickname   # assuming the user model has a name
    end
  end
  
  def self.register_omniauth(auth)
    user = User.new
    user.provider = auth['provider']
    user.uid = auth['uid']
    user.email = auth['info']['email']
    password = Devise.friendly_token[0,20]
    user.password = password
    user.password_confirmation = password
    user.name = auth['info']['name']   # assuming the user model has a name
    user.username = auth['info']['nickname']   # assuming the user model has a name
    user.picture = auth['info']['image'] # assuming the user model has an image
    
    return user  
  end   
end
