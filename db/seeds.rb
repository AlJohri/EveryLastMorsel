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
  unless Role.find_by_name(role)
  # Role.find_or_create_by_name({ :name => role }, :without_protection => true)
    Role.create(name: role)
    puts 'role: ' << role
  end
end
puts 'DEFAULT USERS'

admin = User.create :first_name => ENV['ADMIN_NAME_FIRST'].dup, :last_name => ENV['ADMIN_NAME_LAST'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup, :zip => '99999'
puts 'user: ' << admin.name
admin.add_role :admin

CropType.create(name: "Tomato", description: "description")
CropType.create(name: "Brussels sprouts", description: "description")
CropType.create(name: "Escarole", description: "description")
CropType.create(name: "Broccoli", description: "description")
CropType.create(name: "Carrot", description: "description")
CropType.create(name: "Beet", description: "description")
CropType.create(name: "Bean Dry", description: "description")
CropType.create(name: "Herbs Fennel", description: "description")
CropType.create(name: "Cabbage Chinese", description: "description")
CropType.create(name: "Cucumber Armenian", description: "description")
CropType.create(name: "Pea Green", description: "description")
CropType.create(name: "Gourd Laganaria", description: "description")
CropType.create(name: "Tampala", description: "description")
CropType.create(name: "Sweetcorn", description: "description")
CropType.create(name: "Gourd Luffa Ridge", description: "description")
CropType.create(name: "Amaranth", description: "description")
CropType.create(name: "Leek", description: "description")
CropType.create(name: "Asparagus", description: "description")
CropType.create(name: "Spinach", description: "description")
CropType.create(name: "Gourd benincasa", description: "description")
CropType.create(name: "Popcorn", description: "description")
CropType.create(name: "Chickpea", description: "description")
CropType.create(name: "Soybean", description: "description")
CropType.create(name: "Bean lima", description: "description")
CropType.create(name: "Sweetpotato", description: "description")
CropType.create(name: "Melon", description: "description")
CropType.create(name: "Watermelon", description: "description")
CropType.create(name: "Shallot", description: "description")
CropType.create(name: "Rhubarb", description: "description")
CropType.create(name: "Pumpkin", description: "description")
CropType.create(name: "Kale", description: "description")
CropType.create(name: "Parsnip", description: "description")
CropType.create(name: "Southernpea", description: "description")
CropType.create(name: "Lettuce", description: "description")
CropType.create(name: "Rutabega", description: "description")
CropType.create(name: "Gourd Luffa Sponge", description: "description")
CropType.create(name: "Endive Belgian", description: "description")
CropType.create(name: "Eggplant", description: "description")
CropType.create(name: "Turnip", description: "description")
CropType.create(name: "Pepper", description: "description")
CropType.create(name: "Collard", description: "description")
CropType.create(name: "Cauliflower", description: "description")
CropType.create(name: "Radish Daikon", description: "description")
CropType.create(name: "Okra", description: "description")
CropType.create(name: "Corn Salad", description: "description")
CropType.create(name: "Gourd Momordica", description: "description")
CropType.create(name: "Onion", description: "description")
CropType.create(name: "Radish", description: "description")
CropType.create(name: "Herbs Parsley", description: "description")
CropType.create(name: "Potato", description: "description")
CropType.create(name: "Gourd Cucurbita", description: "description")
CropType.create(name: "Herbs Basil", description: "description")
CropType.create(name: "Endive", description: "description")
CropType.create(name: "Cucumber", description: "description")
CropType.create(name: "Celery", description: "description")
CropType.create(name: "Bean green", description: "description")
CropType.create(name: "Cabbage", description: "description")
CropType.create(name: "Swiss chard", description: "description")
CropType.create(name: "Gourd sechium", description: "description")
CropType.create(name: "Mustard", description: "description")
CropType.create(name: "Squash", description: "description")

# CropVariety.create(name:"variety", description: "desc", crop_id: 1)

# User.find_or_create_by_email :name => 'Al Johri', :email => 'al.johri@gmail.com', :password => 'admin123', :password_confirmation => 'admin123', :zip => '07013'