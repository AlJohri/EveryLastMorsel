ruby '1.9.3'
source 'https://rubygems.org'
gem 'rails', '3.2.13'
group :assets do
  gem 'sass-rails',   '~> 3.2.3' # https://github.com/rails/sass-rails
  gem 'bootstrap-sass', '~> 2.3.2.0' # https://github.com/thomas-mcdonald/bootstrap-sass
  gem 'coffee-rails', '~> 3.2.1' # https://github.com/rails/coffee-rails
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'jquery-fileupload-rails'
  gem 'uglifier', '>= 1.0.3'
  gem "font-awesome-rails", "~> 3.2.1.1"
end

# Authentication Gems
# https://github.com/intridea/omniauth/wiki/List-of-Strategies
gem 'devise', '>= 2.2.3' # https://github.com/plataformatec/devise
gem 'omniauth' # https://github.com/intridea/omniauth
gem 'omniauth-facebook' # https://github.com/mkdynamic/omniauth-facebook
gem 'omniauth-twitter' # https://github.com/arunagw/omniauth-twitter
gem 'omniauth-google-oauth2' # https://github.com/zquestz/omniauth-google-oauth2
gem 'cancan', '>= 1.6.9' # https://github.com/ryanb/cancan
gem 'rolify', '>= 3.2.0' # https://github.com/EppO/rolify
# gem 'inherited_resources' # https://github.com/josevalim/inherited_resources
# gem 'has_scope' # http://github.com/plataformatec/has_scope

# http://railscasts.com/episodes/230-inherited-resources
# https://github.com/plataformatec/responders

gem 'newrelic_rpm' # https://github.com/newrelic/rpm
gem 'paperclip' # https://github.com/thoughtbot/paperclip
gem 'aws-sdk', '~> 1.0' # https://github.com/aws/aws-sdk-ruby
gem 'acts-as-taggable-on' # https://github.com/mbleigh/acts-as-taggable-on
gem "acts_as_follower" # https://github.com/tcocca/acts_as_follower/
gem 'rails3-jquery-autocomplete' # https://github.com/crowdint/rails3-jquery-autocomplete
gem "routing_concerns", "~> 0.1.0" # https://github.com/rails/routing_concerns
gem 'rails_admin', github: 'sferik/rails_admin', branch: 'rails-3.x'

# gem "high_voltage", "~> 1.2.3"
gem 'friendly_id', '~> 4.0.9' # https://github.com/norman/friendly_id
gem 'figaro', '~> 0.7.0' # https://github.com/laserlemon/figaro
gem 'pg', '~> 0.15.1' 
gem 'thin', '~> 1.5.1'
gem "haml", "~> 4.0.3"
gem 'slim', '~> 2.0.0'
gem "gibbon", "~> 0.4.6"
gem 'dalli'

# gem "blogit"
gem "kaminari"

group :development do
  gem "better_errors", "~> 0.9.0"
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem "quiet_assets", "~> 1.0.2"
  gem 'nested_scaffold'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
end
