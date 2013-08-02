# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'

admin = User.create :first_name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup, :zip => '99999'
puts 'user: ' << admin.name
admin.add_role :admin

# Crop.create(name: "Tomato2", description: "desc")
# Variety.create(name:"blah", description: "desc", crop_id: 1)

# User.find_or_create_by_email :name => 'Al Johri', :email => 'al.johri@gmail.com', :password => 'admin123', :password_confirmation => 'admin123', :zip => '07013'