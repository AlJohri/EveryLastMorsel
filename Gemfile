ruby '1.9.3'
source 'https://rubygems.org'
gem 'rails', '3.2.14'

group :assets do
  gem 'sass-rails', '= 3.2.6'                   # https://github.com/rails/sass-rails
  gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => '3'
  gem 'bootstrap-wysihtml5-rails', :require => 'bootstrap-wysihtml5-rails', :git => 'git://github.com/Nerian/bootstrap-wysihtml5-rails.git'
  gem 'bootstrap-datepicker-rails'              # https://github.com/Nerian/bootstrap-datepicker-rails
  gem 'x-editable-rails', '= 1.0.0'             # https://github.com/werein/x-editable-rails
  gem 'coffee-rails', '= 3.2.2'                 # https://github.com/rails/coffee-rails
  gem "compass-rails", "~> 2.0.alpha.0"         # https://github.com/Compass/compass-rails
  gem 'jquery-rails', '= 3.0.2'                 # https://github.com/rails/jquery-rails
  gem 'jquery-ui-rails', '= 3.0.1'              # https://github.com/joliss/jquery-ui-rails
  gem 'jquery-fileupload-rails', '= 0.4.1'      # https://github.com/tors/jquery-fileupload-rails
  gem 'uglifier', '= 2.1.1'                     # https://github.com/lautis/uglifier
  gem 'font-awesome-rails'                      # https://github.com/bokmann/font-awesome-rails
end

gem 'carrierwave'
gem 'bootsy', github: 'volmer/bootsy', branch: 'rails-3.2'
gem 'braintree'
gem 'braintree-rails', :github => "lyang/braintree-rails", :branch => 'master'
gem 'haml'
gem 'slim-rails', '= 2.0.1'                     # https://github.com/slim-template/slim-rails
gem 'devise', '= 2.2.4'                         # https://github.com/plataformatec/devise
gem 'omniauth', '= 1.1.4'                       # https://github.com/intridea/omniauth
gem 'omniauth-facebook', '= 1.4.1'              # https://github.com/mkdynamic/omniauth-facebook
gem 'omniauth-twitter', '= 1.0.0'               # https://github.com/arunagw/omniauth-twitter
gem 'omniauth-google-oauth2', '= 0.2.0'         # https://github.com/zquestz/omniauth-google-oauth2
gem 'cancan', '= 1.6.10'                        # https://github.com/ryanb/cancan
gem 'rolify', '= 3.2.0'                         # https://github.com/EppO/rolify
gem 'geocoder', '= 1.1.8'                       # https://github.com/alexreisner/geocoder
gem 'simple_form', '= 2.0.3'                    # https://github.com/plataformatec/simple_form
gem 'client_side_validations'                   # https://github.com/bcardarella/client_side_validations
gem 'client_side_validations-simple_form', github: 'dockyard/client_side_validations-simple_form', branch: "2-0-stable"
gem 'inherited_resources', '= 1.4.0'            # https://github.com/josevalim/inherited_resources
gem 'has_scope', '= 0.5.1'                      # http://github.com/plataformatec/has_scope
gem 'newrelic_rpm', '= 3.6.5.130'               # https://github.com/newrelic/rpm
gem 'paperclip', '= 3.4.2'                      # https://github.com/thoughtbot/paperclip
gem 'aws-sdk', '= 1.11.1'                       # https://github.com/aws/aws-sdk-ruby
gem 'routing_concerns', '= 0.1.0'               # https://github.com/rails/routing_concerns
gem 'friendly_id', '= 4.0.9'                    # https://github.com/norman/friendly_id
gem 'figaro', '= 0.7.0'                         # https://github.com/laserlemon/figaro
gem 'pg', '= 0.15.1'                            # https://github.com/ged/ruby-pg
gem 'thin', '= 1.5.1'                           # https://github.com/macournoyer/thin/
gem 'gibbon', '= 0.4.6'                         # https://github.com/amro/gibbon
gem 'dalli', '= 2.6.4'                          # https://github.com/mperham/dalli
gem 'faker', '= 1.1.2'                          # https://github.com/btelles/faker
gem 'kaminari', '= 0.14.1'                      # https://github.com/amatsuda/kaminari
gem 'acts-as-taggable-on', '= 2.4.1'            # https://github.com/mbleigh/acts-as-taggable-on
gem 'acts_as_follower', '= 0.1.1'               # https://github.com/tcocca/acts_as_follower/
gem 'acts_as_commentable', '= 3.0.1'            # https://github.com/jackdempsey/acts_as_commentable
gem 'mailboxer'                                 # https://github.com/ging/mailboxer
gem 'public_activity'                           # https://github.com/pokonski/public_activity
gem 'ransack'                                   # https://github.com/ernie/ransack
gem 'sitemap_generator'                         # https://github.com/kjvarga/sitemap_generator
gem 'safe_yaml', '= 0.9.5'
gem 'make_flaggable', :git => 'git://github.com/cavneb/make_flaggable.git'

  # `rspec-rails` needs to be in the development group so that Rails generators work.
group :development, :test do
  gem 'rspec-rails', '= 2.14.0'                 # https://github.com/rspec/rspec-rails
end

group :development do
  gem 'nested_scaffold', '= 0.2.1'              # https://github.com/amatsuda/nested_scaffold
  gem 'quiet_assets', '= 1.0.2'                 # https://github.com/evrone/quiet_assets
  gem 'better_errors', '= 0.9.0'                # https://github.com/charliesome/better_errors
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx] # https://github.com/banister/binding_of_caller  
end

group :test do
  gem 'simplecov', :require => false            # https://github.com/colszowka/simplecov
  gem 'capybara'
  gem "shoulda-matchers"
  gem 'rails-erd', '= 1.1.0'                    # https://github.com/voormedia/rails-erd
end

gem 'rails_admin', :github => 'AlJohri/rails_admin', :branch => 'rails-3.x'

# Other Gems
# https://github.com/vcr/vcr
# https://github.com/jhollingworth/bootstrap-wysihtml5
# https://github.com/Nerian/bootstrap-wysihtml5-rails
# https://github.com/artillery/bootstrap-wysihtml5 -> Pull Request for Rails 3 Support in this repository
# gem 'bootstrap-wysihtml5-rails', '= 0.3.1.21'
# gem 'rails4_upgrade', github: 'alindeman/rails4_upgrade'
# gem 'angularjs-rails'
# gem 'blogit'
# gem 'rails_admin'
# gem 'rails_admin', :github => 'davebrace/rails_admin', :branch => 'use-static-bootstrap-2'
# https://www.ruby-toolbox.com/categories/Web_Analytics
# gem 'rack-google-analytics', '0.11.0', :require => 'rack/google-analytics'
# gem 'rack-piwik', '0.1.3', :require => 'rack/piwik', :require => false
# gem 'rack-ssl', '1.3.2', :require => 'rack/ssl'
# https://www.ruby-toolbox.com/categories/xml_mapping
# http://somerandomdude.com/work/iconic/
# https://github.com/nt/iconic
# https://www.ruby-toolbox.com/categories/Reputation_Engines
# Allow users to rate things
# https://github.com/muratguzel/letsrate
# https://github.com/fabrik42/acts_as_api
# https://github.com/jim/carmen-rails