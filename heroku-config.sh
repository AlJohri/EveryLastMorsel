#! /bin/sh

rake figaro:heroku\[everylastmorsel\]
rake figaro:heroku\[dev-everylastmorsel\]
rake figaro:heroku\[alpha-everylastmorsel\]
rake figaro:heroku\[beta-everylastmorsel\]
rake figaro:heroku\[elm\]


# http://api.cld.me/QFmr/download/mydb.dump

# heroku pgbackups:restore DATABASE 'https://s3.amazonaws.com/f.cl.ly/items/3z2M0z1J023W252q0i33/mydb.dump?AWSAccessKeyId=AKIAJEFUZRCWSLB2QA5Q&Expires=1373849644&Signature=D90XJT0hagfoKfc%2F%2BqgS5jx7nlU%3D&response-content-disposition=attachment' --app elm

# heroku pgbackups:restore DATABASE 'https://s3.amazonaws.com/f.cl.ly/items/3z2M0z1J023W252q0i33/mydb.dump?AWSAccessKeyId=AKIAJEFUZRCWSLB2QA5Q&Expires=1373849644&Signature=D90XJT0hagfoKfc%2F%2BqgS5jx7nlU%3D&response-content-disposition=attachment' --app dev-everylastmorsel