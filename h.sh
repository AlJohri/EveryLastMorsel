#! /bin/sh

DEV="dev-everylastmorsel"
STAGE="elm"
ALPHA="alpha-everylastmorsel"
BETA="beta-everylastmorsel"
MASTER="everylastmorsel"

if [ -z "$1" ]; then
    echo "Uploading environment variables to each heroku app."
    
    echo ""

    echo "rake figaro:heroku[$DEV]";    SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$DEV\]
	echo "rake figaro:heroku[$STAGE]";  SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$STAGE\]
	echo "rake figaro:heroku[$ALPHA]";  SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$ALPHA\]
	echo "rake figaro:heroku[$BETA]";   SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$BETA\]
	echo "rake figaro:heroku[$MASTER]"; SKIP_RAILS_ADMIN_INITIALIZER=true rake figaro:heroku\[$MASTER\]

	echo ""

	echo "Grabbing Facebook Environment Variables from application.yml for each server..."

	FACEBOOK_DEV_APPID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_DEV_APPID'];"`
	FACEBOOK_DEV_APPSECRET=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_DEV_APPSECRET'];"`
	FACEBOOK_STAGE_APPID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_STAGE_APPID'];"`
	FACEBOOK_STAGE_APPSECRET=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_STAGE_APPSECRET'];"`
	FACEBOOK_ALPHA_APPID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_ALPHA_APPID'];"`
	FACEBOOK_ALPHA_APPSECRET=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_ALPHA_APPSECRET'];"`
	FACEBOOK_BETA_APPID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_BETA_APPID'];"`
	FACEBOOK_BETA_APPSECRET=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['FACEBOOK_BETA_APPSECRET'];"`

	echo "Assigning each facebook variable to its respective server..."	

	heroku config:add FACEBOOK_APPID=$FACEBOOK_DEV_APPID --app $DEV
	heroku config:add FACEBOOK_APPSECRET=$FACEBOOK_DEV_APPSECRET --app $DEV
	heroku config:add FACEBOOK_APPID=$FACEBOOK_STAGE_APPID --app $STAGE
	heroku config:add FACEBOOK_APPSECRET=$FACEBOOK_STAGE_APPSECRET --app $STAGE
	heroku config:add FACEBOOK_APPID=$FACEBOOK_ALPHA_APPID --app $ALPHA
	heroku config:add FACEBOOK_APPSECRET=$FACEBOOK_ALPHA_APPSECRET --app $ALPHA
	heroku config:add FACEBOOK_APPID=$FACEBOOK_BETA_APPID --app $BETA
	heroku config:add FACEBOOK_APPSECRET=$FACEBOOK_BETA_APPSECRET --app $BETA
	heroku config:add FACEBOOK_APPID=$FACEBOOK_DEV_APPID --app $MASTER
	heroku config:add FACEBOOK_APPSECRET=$FACEBOOK_DEV_APPSECRET --app $MASTER

	echo "Grabbing Braintree Environment Variables from application.yml for each server..."

	BRAINTREE_PRODUCTION_ENVIRONMENT=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_PRODUCTION_ENVIRONMENT'];"`
	BRAINTREE_PRODUCTION_MERCHANT_ID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_PRODUCTION_MERCHANT_ID'];"`
	BRAINTREE_PRODUCTION_PUBLIC_KEY=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_PRODUCTION_PUBLIC_KEY'];"`
	BRAINTREE_PRODUCTION_PRIVATE_KEY=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_PRODUCTION_PRIVATE_KEY'];"`
	BRAINTREE_SANDBOX_ENVIRONMENT=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_SANDBOX_ENVIRONMENT'];"`
	BRAINTREE_SANDBOX_MERCHANT_ID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_SANDBOX_MERCHANT_ID'];"`
	BRAINTREE_SANDBOX_MASTER_MERCHANT_ID=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_SANDBOX_MASTER_MERCHANT_ID'];"`
	BRAINTREE_SANDBOX_PUBLIC_KEY=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_SANDBOX_PUBLIC_KEY'];"`
	BRAINTREE_SANDBOX_PRIVATE_KEY=`ruby -ryaml -e "data = YAML.load_file('config/application.yml'); puts data['BRAINTREE_SANDBOX_PRIVATE_KEY'];"`

	echo "Assigning each braintree variable to its respective server..."

	heroku config:add BRAINTREE_ENVIRONMENT=$BRAINTREE_SANDBOX_ENVIRONMENT --app $DEV
	heroku config:add BRAINTREE_MERCHANT_ID=$BRAINTREE_SANDBOX_MERCHANT_ID --app $DEV
	heroku config:add BRAINTREE_MASTER_MERCHANT_ID=$BRAINTREE_SANDBOX_MASTER_MERCHANT_ID --app $DEV
	heroku config:add BRAINTREE_PUBLIC_KEY=$BRAINTREE_SANDBOX_PUBLIC_KEY --app $DEV
	heroku config:add BRAINTREE_PRIVATE_KEY=$BRAINTREE_SANDBOX_PRIVATE_KEY --app $DEV
	heroku config:add BRAINTREE_ENVIRONMENT=$BRAINTREE_SANDBOX_ENVIRONMENT --app $STAGE
	heroku config:add BRAINTREE_MERCHANT_ID=$BRAINTREE_SANDBOX_MERCHANT_ID --app $STAGE
	heroku config:add BRAINTREE_MASTER_MERCHANT_ID=$BRAINTREE_SANDBOX_MASTER_MERCHANT_ID --app $STAGE
	heroku config:add BRAINTREE_PUBLIC_KEY=$BRAINTREE_SANDBOX_PUBLIC_KEY --app $STAGE
	heroku config:add BRAINTREE_PRIVATE_KEY=$BRAINTREE_SANDBOX_PRIVATE_KEY --app $STAGE
	heroku config:add BRAINTREE_ENVIRONMENT=$BRAINTREE_SANDBOX_ENVIRONMENT --app $ALPHA
	heroku config:add BRAINTREE_MERCHANT_ID=$BRAINTREE_SANDBOX_MERCHANT_ID --app $ALPHA
	heroku config:add BRAINTREE_MASTER_MERCHANT_ID=$BRAINTREE_SANDBOX_MASTER_MERCHANT_ID --app $ALPHA
	heroku config:add BRAINTREE_PUBLIC_KEY=$BRAINTREE_SANDBOX_PUBLIC_KEY --app $ALPHA
	heroku config:add BRAINTREE_PRIVATE_KEY=$BRAINTREE_SANDBOX_PRIVATE_KEY --app $ALPHA
	heroku config:add BRAINTREE_ENVIRONMENT=$BRAINTREE_PRODUCTION_ENVIRONMENT --app $BETA
	heroku config:add BRAINTREE_MERCHANT_ID=$BRAINTREE_PRODUCTION_MERCHANT_ID --app $BETA
	heroku config:add BRAINTREE_MASTER_MERCHANT_ID=$BRAINTREE_PRODUCTION_MASTER_MERCHANT_ID --app $BETA
	heroku config:add BRAINTREE_PUBLIC_KEY=$BRAINTREE_PRODUCTION_PUBLIC_KEY --app $BETA
	heroku config:add BRAINTREE_PRIVATE_KEY=$BRAINTREE_PRODUCTION_PRIVATE_KEY --app $BETA
	heroku config:add BRAINTREE_ENVIRONMENT=$BRAINTREE_PRODUCTION_ENVIRONMENT --app $MASTER
	heroku config:add BRAINTREE_MERCHANT_ID=$BRAINTREE_PRODUCTION_MERCHANT_ID --app $MASTER
	heroku config:add BRAINTREE_MASTER_MERCHANT_ID=$BRAINTREE_PRODUCTION_MASTER_MERCHANT_ID --app $MASTER
	heroku config:add BRAINTREE_PUBLIC_KEY=$BRAINTREE_PRODUCTION_PUBLIC_KEY --app $MASTER
	heroku config:add BRAINTREE_PRIVATE_KEY=$BRAINTREE_PRODUCTION_PRIVATE_KEY --app $MASTER

	echo "Adding an APP_NAME environment variable to check which server is currently being used"

	heroku config:add APP_NAME=DEV --app $DEV
	heroku config:add APP_NAME=STAGE --app $STAGE
	heroku config:add APP_NAME=ALPHA --app $ALPHA
	heroku config:add APP_NAME=BETA --app $BETA
	heroku config:add APP_NAME=MASTER --app $MASTER

	exit 0
elif [[ "$1" == "migrate" ]]; then
	heroku run SKIP_RAILS_ADMIN_INITIALIZER=true rake db:migrate --app $DEV
	heroku run SKIP_RAILS_ADMIN_INITIALIZER=true rake db:migrate --app $STAGE
	heroku run SKIP_RAILS_ADMIN_INITIALIZER=true rake db:migrate --app $BETA
	# heroku run SKIP_RAILS_ADMIN_INITIALIZER=true rake db:migrate --app $ALPHA
	# heroku run SKIP_RAILS_ADMIN_INITIALIZER=true rake db:migrate --app $MASTER
elif [[ "$1" == "restart" ]]; then
	heroku restart --app $DEV
	heroku restart --app $STAGE
	heroku restart --app $BETA
	heroku restart --app $ALPHA
	heroku restart --app $MASTER
elif [[ "$1" == "reset" ]]; then
	heroku pg:reset DATABASE --app $DEV
	heroku pg:reset DATABASE --app $STAGE
	heroku pg:reset DATABASE --app $BETA
	heroku pg:reset DATABASE --app $ALPHA
	heroku pg:reset DATABASE --app $MASTER
fi

# http://api.cld.me/QFmr/download/mydb.dump
# heroku pgbackups:restore DATABASE '' --app elm

# heroku run bundle exec gem pristine nokogiri --app $DEV
# heroku run bundle exec gem pristine nokogiri --app $STAGE
# heroku run bundle exec gem pristine nokogiri --app $ALPHA
# heroku run bundle exec gem pristine nokogiri --app $BETA
# heroku run bundle exec gem pristine nokogiri --app $MASTER
