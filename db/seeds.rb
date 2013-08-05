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

admin = User.create :first_name => ENV['ADMIN_NAME_FIRST'].dup, :last_name => ENV['ADMIN_NAME_LAST'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup, :zip => '99999'
puts 'user: ' << admin.name
admin.add_role :admin

Crop.create(name: "Tomato", description: "description")
Crop.create(name: "Brussels sprouts", description: "description")
Crop.create(name: "Escarole", description: "description")
Crop.create(name: "Broccoli", description: "description")
Crop.create(name: "Carrot", description: "description")
Crop.create(name: "Beet", description: "description")
Crop.create(name: "Bean Dry", description: "description")
Crop.create(name: "Herbs Fennel", description: "description")
Crop.create(name: "Cabbage Chinese", description: "description")
Crop.create(name: "Cucumber Armenian", description: "description")
Crop.create(name: "Pea Green", description: "description")
Crop.create(name: "Gourd Laganaria", description: "description")
Crop.create(name: "Tampala", description: "description")
Crop.create(name: "Sweetcorn", description: "description")
Crop.create(name: "Gourd Luffa Ridge", description: "description")
Crop.create(name: "Amaranth", description: "description")
Crop.create(name: "Leek", description: "description")
Crop.create(name: "Asparagus", description: "description")
Crop.create(name: "Spinach", description: "description")
Crop.create(name: "Gourd benincasa", description: "description")
Crop.create(name: "Popcorn", description: "description")
Crop.create(name: "Chickpea", description: "description")
Crop.create(name: "Soybean", description: "description")
Crop.create(name: "Bean lima", description: "description")
Crop.create(name: "Sweetpotato", description: "description")
Crop.create(name: "Melon", description: "description")
Crop.create(name: "Watermelon", description: "description")
Crop.create(name: "Shallot", description: "description")
Crop.create(name: "Rhubarb", description: "description")
Crop.create(name: "Pumpkin", description: "description")
Crop.create(name: "Kale", description: "description")
Crop.create(name: "Parsnip", description: "description")
Crop.create(name: "Southernpea", description: "description")
Crop.create(name: "Lettuce", description: "description")
Crop.create(name: "Rutabega", description: "description")
Crop.create(name: "Gourd Luffa Sponge", description: "description")
Crop.create(name: "Endive Belgian", description: "description")
Crop.create(name: "Eggplant", description: "description")
Crop.create(name: "Turnip", description: "description")
Crop.create(name: "Pepper", description: "description")
Crop.create(name: "Collard", description: "description")
Crop.create(name: "Cauliflower", description: "description")
Crop.create(name: "Radish Daikon", description: "description")
Crop.create(name: "Okra", description: "description")
Crop.create(name: "Corn Salad", description: "description")
Crop.create(name: "Gourd Momordica", description: "description")
Crop.create(name: "Onion", description: "description")
Crop.create(name: "Radish", description: "description")
Crop.create(name: "Herbs Parsley", description: "description")
Crop.create(name: "Potato", description: "description")
Crop.create(name: "Gourd Cucurbita", description: "description")
Crop.create(name: "Herbs Basil", description: "description")
Crop.create(name: "Endive", description: "description")
Crop.create(name: "Cucumber", description: "description")
Crop.create(name: "Celery", description: "description")
Crop.create(name: "Bean green", description: "description")
Crop.create(name: "Cabbage", description: "description")
Crop.create(name: "Swiss chard", description: "description")
Crop.create(name: "Gourd sechium", description: "description")
Crop.create(name: "Mustard", description: "description")
Crop.create(name: "Squash", description: "description")

# Variety.create(name:"blah", description: "desc", crop_id: 1)

# User.find_or_create_by_email :name => 'Al Johri', :email => 'al.johri@gmail.com', :password => 'admin123', :password_confirmation => 'admin123', :zip => '07013'