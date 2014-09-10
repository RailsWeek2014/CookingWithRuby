Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'f2c13c1c9c2f40643600', '0a4072b65f834abd8aaec86967d1d19e64b5fc59'
  provider :twitter, 'Dj1IKSypPohb6pt42re7UWzx7', '2RrdPqqfohEftWDoNnfOOa7DvJgEUKGfDxxMymDyvDgXwVSxfF'
  provider :google_oauth2, '192659461881-3dpteo0hpgs9p2c3lqe623cee44robrr.apps.googleusercontent.com', 'Bw_7LutAD5G3yV_E54qWmyI1'
end