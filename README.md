#Unchained
Unchained Enterprise is GALE’s agile commerce and content marketing technology stack. Allowing marketers to quickly implement new cross-platform digital experiences, manage the content, and quickly analyze the impact, Unchained is built for today's marketing challenges with its adaptable nature and user-friendly interface.

##Installing UnchainedCommerce

```
clone repo at https://github.com/zahnno/Solidus
cd solidus
vagrant up
vagrant ssh
cd solidus
cd Unchainedcommerce
rvm install 2.1.0
rvm --default use 2.1.0
rvm gemset create unchainedcommerce
rvm gemset use unchainedcommerce
rvm use ruby-2.1.0@unchainedcommerce —default
gem install rails -v 4.2.2 --no-ri --no-rdoc
gem install bundler
bundle update
bundle install
rails g spree:install
rake railties:install:migrations
rake db:migrate
```

##API CALLS

######Follow link below for all api calls.

http://zahnno.github.io/
