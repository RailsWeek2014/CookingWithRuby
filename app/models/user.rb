class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, omniauth_providers: [:github, :twitter, :google_oauth2]
         
  validates :name, presence: true       
  
  has_many :recipes
  has_many :comments
  has_many :meal_plans
  has_many :cookbooks
  has_many :activity_plans
  has_many :identities
  
  #tutorial from: http://stackoverflow.com/questions/21249749/rails-4-devise-omniauth-with-multiple-providers
  def self.from_omniauth(auth, current_user)
    y auth

    identity = Identity.where(:provider => auth.provider, :uid => auth.uid.to_s, 
                                        :token => auth.credentials.token, 
                                        :secret => auth.credentials.secret).first_or_initialize
    identity.profile_page = auth.info.urls.first.last unless identity.persisted?
    if identity.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        #user.skip_confirmation!
        user.password = Devise.friendly_token[0, 20]
        user.fetch_details(auth)
        user.save
      end
      identity.user = user
      identity.save
    end
    identity.user
  end
  
  def fetch_details(auth)
    self.name = auth.info.name
    self.username = auth.info.nickname
    self.email = auth.info.email || Random.rand(10000..10000000).to_s + "@email." + auth.provider
    self.picture = auth.info.image
    if self.email == 'hoppe.marcel@gmail.com'
      self.role = 'a'
    end
    if self.email == 'schilling.mareike@gmail.com'
      self.role = 'm'
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
