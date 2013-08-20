class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  paginates_per 8

  has_many :posts
  # has_many :plots
  has_and_belongs_to_many :plots
  before_create :concatenate_name
  before_create :geocode_zip  
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
  # FIELDS = [:first_name, :last_name, :phone, :website, :company, :fax, :addresses, :credit_cards, :custom_fields]
  FIELDS = [:first_name, :last_name, :name, :email, :city, :state, :zip, :url]
  attr_accessor *FIELDS
  attr_accessible :role_ids, :as => :admin
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid, :about
  attr_accessible :avatar
  attr_accessible :braintree_customer_id
  attr_reader :avatar_remote_url

  validates :zip, presence: true

  make_flagger
  acts_as_tagger
  acts_as_follower
  acts_as_followable
  acts_as_messageable
  
  has_attached_file :avatar, 
    :default_url => "/assets/placeholder_:style.jpg", 
    :styles => {
      thumb: '100x100#',
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

    location = Geocoder.search(auth.info.location)
    if location.present?
      city = location[0].city
      state = location[0].state
    end

    unless user
      user = User.new(
              name: auth.extra.raw_info.name,
              first_name: auth.info.first_name,
              last_name: auth.info.last_name,
              city: city,
              state: state,
              zip: '99999',
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
                city: city,
                state: state,
                zip: '99999',
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
              city: '',
              state: '',
              zip: '99999',
              url: auth.info['urls']['Google'],
              provider: auth.provider,
              email: auth.info["email"],
              password: Devise.friendly_token[0,20],
              uid: auth.uid
            )
      # user.skip_confirmation!
      user.save
      user.avatar_remote_url(auth.info.image, user.slug)
    end
    user
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    return email
    #if false
    #return nil
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
  
  def crops
    Crop.where(:plot_id => self.plots.pluck(:id))
  end

  def concatenate_name
    self.name = "#{first_name} #{last_name}"
  end

  def geocode_zip
    location = Geocoder.search(zip)
    if location.present?
      self.city = location[0].city
      self.state = location[0].state
    end

    #puts self.city
    #puts self.state
    #puts self.zip
  end

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
end