Every Last Morsel
=================

Set Up
---------------
	$ git clone git@github.com:AlJohri/EveryLastMorsel.git
	$ cd EveryLastMorsel
	$ cp ~/Downloads/application.yml ./config/ `# download application.yml first'
	$ bundle install
	$ rake db:create
	$ vim config/application.yml `# modify ADMIN_NAME_FIRST, ADMIN_LAST_NAME, ADMIN_EMAIL`
	$ rake db:seed
	$ rails s
________________________

Design Decisions
----------------
The ELM codebase tries to accomplish as much as possible while remaining as concise as possible. Where feasible, I am outsourcing functionality such as [tagging](https://github.com/mbleigh/acts-as-taggable-on), [commenting](https://github.com/mbleigh/acts-as-taggable-on), [following](https://github.com/tcocca/acts_as_follower/), [liking](https://github.com/cavneb/make_flaggable), [messaging](https://github.com/ging/mailboxer), etc. to a gem. The majority of the gems I'm using are well tested. Ideally, those that are not should, at a later date, have their functionality replicated within ELM or modify the functionality of the gem itself.

### Inherited Resources

Every Last Morsel currently makes heavy use of [InheritedResouces](https://github.com/josevalim/inherited_resources) to create polymorphic controllers. I may convert these to custom polymorphic controllers or modify InheritedResouces itself to meet any future needs.

### Polymorphic Controller Design Pattern

The heavy use of polymorphic controllers is necessitated by the highly contextualized design. Each object can be viewed in multiple contexts: in the context of itself, in the context of a user profile, or in the context of a plot profile. To enable using a single polymorphic controller for these different views I make use of the ["Optional Belongs To"](https://github.com/josevalim/inherited_resources#optional-belongs-to) functionality within InheritedResources. This allows each resource to not only be nested, accesed in the context of its parent, but also to be independent, accessed in the context of itself.

In an effort to maintain relatively logicless views and keep thin controllers, instead of adding conditionals to change the view within the controller OR conditionals to change the content within the view, I added a "context" to each view.

To elaborate, this is the folder structure for a particular resource (Crops).

    * app/views/crops
        * partials
            * _index, _new, _show, _edit, _form
        * plots
            * index, new, show, edit, _form
        * users
            * index, new, show, edit, _form

Instead of routing to app/views/crops/#{action}.slim, I'm routing to app/views/crops/#{context}/#{action}.slim.

To accomplish this change I made a small override to the render function within ApplicationController like so:

    def render(*args)

        # Check if controller inherits from InheritedResources::Base
        # If so, change view route to prepend "#{context}"
        # to serve the correct view.

        #&& (request.format == "text/html") # && (!request.xhr?)
        #context = parent? ? parent_class.to_s.downcase.pluralize : "self" # parent_type.to_s.downcase.pluralize    

        options = args.extract_options!

        if (!options[:location]) && (self.class.ancestors.include? InheritedResources::Base)
          action = options[:action] || action_name
          context = parent? ? parent_type.to_s.downcase.pluralize : "self"
          path = "#{controller_name}/#{context}/#{action}"
        end

        options[:template] = path if context != nil
        super(*(args << options))

    end

#### Summary

Every Last Morsel loves Inherited Resources. Inherited Resources makes the creation of polymorphic controllers much easier. Resources in ELM need to be viewed in multiple contexts. The render method is overridden to accomodate for this. The overridden render method creates the following folder structure: **resource first, context second.**

#### Examples

**Where would I find the view for a list of plots within the user profile?**
views/plots/users/index.slim

**Where would I find the view for a list of crops within the plot profile?**
views/crops/plots/index.slim

**Where would I find the view for a list of posts within the user profile?**
views/posts/users/index.slim

**Where would I find the view for an individual plot within the user profile?**
Doesn't exist! Viewing an individual plot profile must be done from a plot profile. If this did exist it would be views/plots/users/show.slim

### Service Objects Design Pattern

Check out this Code Climate blog post on [7 ways to decompose fat activerecord models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/).

Check out this [RailsCast on Service Objects](http://railscasts.com/episodes/398-service-objects).

I prefer to use Service Objects over concerns. This will be reflected in future work.

### Entity-Relationship Diagram

Last Updated: August 11th, 2013
Check out the [Entity-Relationship Diagram](https://github.com/AlJohri/EveryLastMorsel/blob/develop/erd.pdf) for a better idea of the model relationships.
________________________

Servers
---------------
    Development: dev.everylastmorsel.com -> dev-everylastmorsel.herokuapp.com
    Alpha: alpha.everylastmorsel.com -> alpha-everylastmorsel.herokuapp.com ** currently disabled
    Beta: beta.everylastmorsel.com -> beta-everylastmorsel.herokuapp.com
    Main: everylastmorsel.com -> everylastmorsel.herokuapp.com

    Staging: elm.herokuapp.com

### Figaro

[Figaro](https://github.com/laserlemon/figaro) is a simple gem that helps manage environment variables for Rails apps (especially open source). It works seamlessly with Heroku by uploading the config/application.yml file to Heroku.

### h.sh

To keep environment environment variables in sync between multiple servers, I wrote a small shell script h.sh to push the these variables to all servers. 

    echo "rake figaro:heroku[$DEV]";    rake figaro:heroku\[$DEV\]
    echo "rake figaro:heroku[$STAGE]";  rake figaro:heroku\[$STAGE\]
    echo "rake figaro:heroku[$ALPHA]";  rake figaro:heroku\[$ALPHA\]
    echo "rake figaro:heroku[$BETA]";   rake figaro:heroku\[$BETA\]
    echo "rake figaro:heroku[$MASTER]"; rake figaro:heroku\[$MASTER\]

The h.sh script also sets the environment variables based on which server its uploading to.

For example, Facebook only allows a single server to link to an application. The h.sh script reconfigures the _FACEBOOK\_APPID_ and _FACEBOOK\_APPSECRET_ for each server to allow FB login within multiple environments. Similarly, BrainTree has different environment variables for its Sandbox and Production.

________________________

The Innards
---------------

### Basics
* Web Framework: Rails 3.2.14
* Database: [PostgreSQL](https://github.com/ged/ruby-pg) ([ActiveRecord](https://github.com/rails/rails/tree/master/activerecord))
* Server: [Thin](https://github.com/macournoyer/thin/)
* Documentation: [RDoc](https://github.com/rdoc/rdoc) *(not yet)
* Testing: [RSpec](https://github.com/rspec/rspec-rails) with [Cucumber](https://github.com/cucumber/cucumber-rails) *(not yet)

### Tools
* Admin: [Rails Admin](https://github.com/sferik/rails_admin)
* Search: [Ransack](https://github.com/ernie/ransack)
* Controllers: [Inherited Resources](https://github.com/josevalim/inherited_resources) with [Has Scope](http://github.com/plataformatec/has_scope)
* Configuration: [Figaro](https://github.com/laserlemon/figaro)
* UML Diagrams: [Rails ERD](https://github.com/voormedia/rails-erd)

### Building Blocks
* Authentication: [Devise](https://github.com/plataformatec/devise) + [Omniauth](https://github.com/intridea/omniauth)
* Authorization: [CanCan](https://github.com/ryanb/cancan) with [Rollify](https://github.com/EppO/rolify)
* Pagination: [Kaminari](https://github.com/amatsuda/kaminari)
* Vanity URLS: [Friendly ID](https://github.com/norman/friendly_id)
* Image Uploads: [Paperclip](https://github.com/thoughtbot/paperclip)
* Geocoding: [Geocoder](https://github.com/alexreisner/geocoder)

### Features
* Tagging: [Acts As Taggable On](https://github.com/mbleigh/acts-as-taggable-on)
* Following: [Acts As Follower](https://github.com/tcocca/acts_as_follower/)
* Commenting: [Acts As Commentable](https://github.com/jackdempsey/acts_as_commentable)
* Messaging: [Mailboxer](https://github.com/ging/mailboxer)
* Liking: [Make Flaggable](https://github.com/cavneb/make_flaggable)
* Newsfeed: [Public Activity](https://github.com/pokonski/public_activity)

### Frontend
* HTML Markup Language: [Slim](https://github.com/slim-template/slim-rails)
* CSS Markup Langauge: [SASS](https://github.com/rails/sass-rails)
* CSS Framework: [Compass](https://github.com/Compass/compass-rails)
* Frontend Framework: [Bootstrap Sass 2](https://github.com/thomas-mcdonald/bootstrap-sass)
* Forms: [Simple Form](https://github.com/plataformatec/simple_form)

### External API
* Mailchimp API: [Gibbon](https://github.com/amro/gibbon)

### Rails 4 Goodies
* Concerns: [Routing Concerns](https://github.com/rails/routing_concerns)

________________________

License

Links For Future Blogs and Gems to Consider

http://37signals.com/svn/posts/3372-put-chubby-models-on-a-diet-with-concerns
http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/
https://github.com/thoughtbot/paperclip/wiki/Thumbnail-Generation
http://mfischer.com/wordpress/2009/02/02/multiple-image-upload-and-crop-with-rails/comment-page-1/