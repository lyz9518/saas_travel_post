# GoodPoints

GoodPoints is designed for exploring zipcode-based interesting locations. 

## Team Member
* Chen Li     cl4155
* Yao Luo     yl4855
* Yuzhao Liu  yl4897
* Ze Ma       zm2385

## To run the application

### Dependencies
* Ruby 2.6.6
* Git

### Install Packages
* Check your ruby version
```
which ruby
```
* Install ruby Gems
```
bundle install
```
* Set up Local SQLite3 Database
```
bin/rake db:setup
```

* Start the application locally
```
bundle exec rerun -- rackup --port 3000
```

* Cucumber User Test
```
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec cucumber
```

* Heroku Setup

This application has been deployed on Heroku. You may access it thru the link below.

[GoodPoints](https://cryptic-everglades-19398.herokuapp.com/)

Set up heroku server by following the commands below
```
heroku apps:create (may have to change heroku stack if prompted stack version error)
git push heroku master 
heroku run rake db:migrate
heroku run rake db:seed
```