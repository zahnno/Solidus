#Setting the Project Up

```
clone repo at https://github.com/zahnno/Solidus
cd solidus
vagrant up
vagrant ssh
cd solidus
cd Unchainedcommerce
rvm install 2.1.0
rvm --default use 2.1.0
rvm gemset create unchained commerce
rvm gemset use unchained commerce
rvm use ruby-2.1.0@unchainedcommerce —default
gem install rails -v 4.2.2 --no-ri --no-rdoc
gem install bundler
bundle update
bundle install
rails g spree:install
railties:install:migrations
rake db:migrate
```

#API CALLS

http://zahnno.github.io/
