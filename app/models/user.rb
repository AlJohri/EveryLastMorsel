class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.new(
              name: auth.extra.raw_info.name,
              provider: auth.provider,
              uid: auth.uid,
              email: auth.info.email,
              password: Devise.friendly_token[0,20]
            )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
      user = User.where(:name => auth.extra.raw_info.screen_name).first
      unless user
          #Hack to resolve the required email issue with Twitter and Devise
          user = User.new(
                  name: auth.extra.raw_info.screen_name, 
                  email: "#{auth.extra.raw_info.screen_name}@twitter.com", 
                  password: Devise.friendly_token[0,20]
                )
          user.skip_confirmation!
          user.save
      end
      user
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
      user = User.where(:email => auth.info["email"]).first
      unless user
        user = User.new(
                name: auth.info["name"],
                email: auth.info["email"],
                password: Devise.friendly_token[0,20]
              )
        user.skip_confirmation!
        user.save
      end
      user
  end

end
