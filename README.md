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

Every Last Morsel currently makes heavy use of [InheritedResouces](https://github.com/josevalim/inherited_resources) to create polymorphic controllers. I may convert these to custom polymorphic controllers or modify InheritedResouces itself to meet any future needs.

The heavy use of polymorphic controllers is necessitated by the highly contextualized design. Each object can be viewed in multiple contexts: in the context of itself, in the context of a user profile, or in the context of a plot profile. To enable using a single polymorphic controller for these different views I make use of the ["Optional Belongs To"](https://github.com/josevalim/inherited_resources#optional-belongs-to) functionality within InheritedResources. This allows each resource to not only be nested, accesed in the context of its parent, but also to be independent, accessed in the context of itself.

In an effort to maintain relatively logicless views and keep thin controllers, instead of adding conditionals to change the view within the controller OR conditionals within the view to change the content, I added a "context" to each view.

To elaborate, this is the folder structure for a particular resource (PlotCropVariety).

    * app/views/plot_crop_varieties
        * partials
            * _index, _new, _show, _edit, _form
        * context
            * plots
                * index, new, show, edit, _form
            * users
                * index, new, show, edit, _form

Instead of routing to app/views/plot\_crop\_varieties/action.slim, I'm routing to app/views/plot\_crop\_varieties/context/#{context}/action.slim.

To accomplish this change I made a small override to the render function within ApplicationController like so:

    def render(*args)

    # Check if controller inherits from InheritedResources::Base
    # If so, change view route to prepend "context/#{context}"
    # to serve the correct view.

    if self.class.ancestors.include? InheritedResources::Base
      context = parent? ? parent_class.to_s.pluralize : "self" # parent_type.to_s.capitalize.pluralize
      path = "#{controller_name}/context/#{context}/#{action_name}"
    end

    options = args.extract_options!
    options[:template] = path if context != nil
    super(*(args << options))
    end

### Controllers
* Devise::Custom::OmniauthCallbacksController
* Devise::Custom::RegistrationsController
* ActivitiesController
* ApplicationController
* CommentsController
* CropsControllers
* PlotCropVarietiesController
* PlotsController
* PostsController
* StaticController
* UsersController
* VarietiesController
* YieldsController

### Models
* Ability
* Comment
* Follow
* Crops (has_many Varieties)
* Plot (has_many PlotCropVarieties, has_many Crops through PlotCropVarieties, has_many Varieties through PlotCropVarieties)
* PlotCropVariety (belongs_to Plot, belongs_to Crop, belongs_to Variety, has_many Yields)
* Post (belongs_to User)
* Role (belongs_to User)
* User (has_many Posts, has_and_belongs_to_many Plots, has_many Roles)
* Variety (belongs_to Crop, belongs_to PlotCropVarietiy)
* Yield (belongs_to PlotCropVariety)

Check out the [Entity-Relationship Diagram](https://github.com/AlJohri/EveryLastMorsel/blob/develop/erd.pdf) for a better idea of the model relationships.
________________________

Servers
---------------
Development: dev.everylastmorsel.com -> dev-everylastmorsel.herokuapp.com
Alpha: alpha.everylastmorsel.com -> alpha-everylastmorsel.herokuapp.com ** currently disabled
Beta: beta.everylastmorsel.com -> beta-everylastmorsel.herokuapp.com
Main: everylastmorsel.com -> everylastmorsel.herokuapp.com

Staging: elm.herokuapp.com

Currently using simple shell script (h.sh) to push environment variables to all servers (via figaro).

    echo "rake figaro:heroku[$DEV]";    SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$DEV\]
    echo "rake figaro:heroku[$STAGE]";  SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$STAGE\]
    echo "rake figaro:heroku[$ALPHA]";  SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$ALPHA\]
    echo "rake figaro:heroku[$BETA]";   SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$BETA\]
    echo "rake figaro:heroku[$MASTER]"; SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$MASTER\]

Because facebook only allows a single server to link to an application, the h.sh script also reconfigures the FACEBOOK_APPID and FACEBOOK_APPSECRET for each server to allow fb login within all* environments. (* just Dev and Beta for now)
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


https://github.com/thoughtbot/paperclip/wiki/Thumbnail-Generation
http://mfischer.com/wordpress/2009/02/02/multiple-image-upload-and-crop-with-rails/comment-page-1/