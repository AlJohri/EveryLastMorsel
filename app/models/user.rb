class User < ActiveRecord::Base
  has_many :posts
  has_many :plots
  # after_create :update_mailchimp
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]
         # :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :first_name, :last_name, :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid, :about
  attr_accessible :city, :state, :zip
  attr_accessible :url
  attr_accessible :avatar
  attr_reader :avatar_remote_url

  validates :zip, presence: true

  make_flagger
  
  has_attached_file :avatar, 
    :default_url => "/assets/placeholder_:style.jpg", 
    :styles => {
      thumb: '100x100',
      square: '200x200#',
      medium: '300x300#'
    }
  
  def avatar_remote_url(url_value, file_name)
    if url_value != nil
      self.avatar = uri = URI.parse(URI.encode(url_value.strip))
      self.avatar_file_name = file_name
      # self.avatar_content_type == "image/png"
      @avatar_remote_url = url_value
    end
  end

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def name
    "#{first_name} #{last_name}"
  end  

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
              first_name: auth.info.first_name,
              last_name: auth.info.last_name,
              city: auth.info.location,
              zip: auth.info.image,
              url: auth.info['urls']['Facebook'],
              provider: auth.provider,
              uid: auth.uid,
              email: auth.info.email,
              password: Devise.friendly_token[0,20]
            )
      # user.skip_confirmation!
      user.save
      user.avatar_remote_url(auth.info.image, user.slug)
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
      user = User.where(:name => auth.extra.raw_info.screen_name).first
      unless user
          #Hack to resolve the required email issue with Twitter and Devise
          user = User.new(
                  name: auth.info.name,  #extra.raw_info.screen_name
                  first_name: auth.info.name[0],
                  last_name: auth.info.name[1],
                  city: auth.info.location,
                  about: auth.info.description,
                  url: auth.info['urls']['Twitter'],
                  email: "#{auth.extra.raw_info.screen_name}@twitter.com", 
                  password: Devise.friendly_token[0,20]
                )
          # user.skip_confirmation!
          user.save
          user.avatar_remote_url(auth.info.image, user.slug)
      end
      user
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
      user = User.where(:email => auth.info["email"]).first
      unless user
        puts auth
        user = User.new(
                name: auth.info["name"],
                first_name: auth.info["first_name"],
                last_name: auth.info["last_name"],
                # city: "",
                url: auth.info['urls']['Google'],
                provider: auth.provider,
                email: auth.info["email"],
                password: Devise.friendly_token[0,20]
                # uid: auth.info["id"],
              )
        # user.skip_confirmation!
        user.save
        user.avatar_remote_url(auth.info.image, user.slug)
      end
      user
  end

  def update_mailchimp
    gb = Gibbon.new
    ret = gb.list_subscribe({:id => '814352e0b3', :email_address => self.email, :merge_vars => {:FNAME => self.first_name, :LNAME => self.last_name, :MMERGE3 => self.city, :MMERGE4 => self.created_at }})
    
    if ret == false
      if ret['code'] == 214 # Email was already in MailChimp List
        Rails.logger.debug(ret['error'])
      end
    end

  end

end