# GoodPoints

GoodPoints is designed for exploring zipcode-based interesting locations. Different than Google Maps and other competitors, GoodPoints only focuses on finding interesting locations base on specific zipcode. Google Maps does not provide such functionality neither does Yelp. This is a great application for location digging explorating. 



GitHub Repo: [https://github.com/lyz9518/saas_travel_post](https://github.com/lyz9518/saas_travel_post)

## Team Member
* Chen Li     cl4155
* Yao Luo     yl4855
* Yuzhao Liu  yl4897
* Ze Ma       zm2385

## To run the application

### Dependencies
* Ruby 2.6.6
* rails 4.2.11
* Git

### OS Requirements
* Tested on ARM based Apple M1 Macbook Pro
* macOS Monterey 12.3.1

### Install Packages
* Check your ruby version
```
which ruby
```
* Install ruby Gems (DO NOT ADD --without production)
```
bundle install
```
* Set up Local SQLite3 Database
```
bin/rake db:setup
```

* Cucumber User Test
```
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec cucumber
```

* Unit Test
```
rspec
```

* Start the application locally
```
bundle exec rerun -- rackup --port 3000
```

* Heroku Setup

This application has been deployed on Heroku. You may access it through the link below.

[GoodPoints](https://cryptic-everglades-19398.herokuapp.com/)

* Project Demo Video

https://www.youtube.com/watch?v=UcBqx7KTfyc

* Presentation Deck

https://docs.google.com/presentation/d/1oUZFl54wTkG9L_XGlQPqeR-MlqKOHyrKNfcKk7QG5Sw/edit?usp=sharing


WARNING:
Heroku has eliminated the free version thus do not run this if you don't have Eco Dyno subscriptions, run the command below to anable Eco Dyno:
```
heroku ps:scale web=1
```


Set up heroku server by following the commands below
```
heroku apps:create (may have to change heroku stack if prompted stack version error)
git push heroku
heroku run rake db:migrate
heroku run rake db:seed
```

## Team Collaboration Notice
Four team members were doing pair programming at the time of development. Git record may distinct from actual execution. All team members worked equally hard to accomplish the project goal.