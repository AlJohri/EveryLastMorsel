require 'rack-server-pages'
require 'sinatra'
require 'tilt'
require 'slim'
require 'gibbon'

run Sinatra::Application

use Rack::ServerPages

require './config/env' if File.exists?('./config/env.rb')

Gibbon.api_key = ENV['MAILCHIMP_API_KEY']
Gibbon.throws_exceptions = false

get '/subscribe' do
	email = params[:email]
	gb = Gibbon.new
	ret = gb.list_subscribe({:id => '814352e0b3', :email_address => email, :double_optin => false, :send_welcome => false })
	# :merge_vars => {:FNAME => self.first_name, :LNAME => self.last_name, :MMERGE3 => self.city, :MMERGE4 => self.created_at }
	ret.to_s
end