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
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

Person.create(:email => 'nnn@gmail.com', :password => 'foobar', :password_confirmation => 'foobar', :first_name => 'nn', :last_name => 'yy')


Post.create(:user_id => user.id, :title => "Savory Summer: Week 2 at Coolhouse Labs", :content => 
	"We’re playing catch up, so here’s a peek into our second week at Coolhouse Labs through the meals we’ve shared. What better way to start off the week than with some farm fresh eggs! Delivered via woven basket by the librarian, the Coolhouse cohort divvied them up.
	A few days later we met with Eric Liberman for lunch at Turkey’s Cafe & Pizzeria on Main Street. We all ordered the Garden Burger, a veggie burger with lettuce, tomato, onions and pickles. It did not disappoint.
	On Friday we traveled to Petoskey, just a 15 minute drive from our home in Harbor Springs. We stopped at the farmer’s market in the morning and were delighted to see a large number of vendors and a sizable crowd.
	In the afternoon we met with the good people of American Spoon, a Michigan-made company that’s famous for their fruit preserves. We’ll be blogging about our experience soon, but until then here’s what we tasted at their cafe in Petoskey’s historic Pennsylvania Park. Note that most, if not all, items on the menu are prepared seasonally with ingredients from local farmers and foragers!
	May I also note that the Strawberry Mint sorbetto was indeed the best thing I have tasted thus far in Michigan. Not only was it perfectly refreshing for a summer day, I also found out that one of the owners Justin Rashid had gathered the wild mint recently on one of this foraging trips.")
Post.create(:user_id => user.id, :title => "Savory Summer: Week 1 at Coolhouse Labs", :content =>
	"In an effort to document our experience this summer, we’ll be writing a series of blog posts about life in Harbor Springs. And what better way to document this experience than to show you the meals we share with the people around us. After all, meals are often the most enjoyable and memorable part of our days. Amirite?
	Harbor Springs is an idyllic city. Small shops, local businesses,  and family stores line the main street. Then of course there’s the Coolhouse Labs co-working space – a little reminder of the big city in this small town. “The lab”, as I like to call it, has a bright and open floor plan that encourages us to use our fellow companies as a sounding board.
	We arrived Sunday night, so Todd, Al, and I had a team dinner at our new house.
	The first day in the lab was like the first day at summer camp. There were nerves, there was excitement, and there was outdoor activity. As a team-building/ice-breaking experiment, Coolhouse challenged each team to brand their own bottled water and sell it on the streets of Harbor Springs. We had 45 minutes to come up with a brand, and 45 minutes to sell the water. While we may not have won for branding (shoutout to TRNK New York), we did raise the most money.
	The evening ended with a group dinner on the lake. Great friends, a beautiful sunset, and of course a delicious meal!
	The next few days we’re spent working on our pitch and initial strategy in preparation for a slew of mentor meetings we’d be having the rest of the week. One of our favorite aspects of the program thus far has been the access to some really COOL mentors. From VCs to past startup CEOs the list of mentors is diverse, and is giving the teams here a variety of perspectives — all very helpful.
	Wednesday morning was our first taste of the local farmers market, which had over a dozen different stands. We bought some seedlings for the backyard garden we wanted to plant and talked to the producers. We also stocked up on some fresh veggies for dinner. Since we hadn’t had a chance to get to know our housemates yet, we planned a “family cookout” on the patio.
	All week we had been hearing about Pond Hill farm, so on Saturday we drove over to the farm for a pig roast. We talked with the owner Jimmy, got an intro to the local wine by the bartender, and enjoyed a wonderful buffet outside on the patio.")