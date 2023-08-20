class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(email:auth[:info][:email])
    user.full_name = auth[:info][:name]
    user.uid= auth[:uid]
    user.provider= auth[:provider]
    user.avatar_url = auth[:info][:image]
    user.password = SecureRandom.hex(15)
    user.save if user.changed?
    user
  end
end
