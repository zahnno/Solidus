# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

 config.vm.box = "ubuntu/trusty64"

 config.vm.network "forwarded_port", guest: 8000, host: 8000,
 auto_correct: true

 config.vm.network "forwarded_port", guest: 8080, host: 8080,
 auto_correct: true

 config.vm.network "forwarded_port", guest: 8001, host: 8001,
 auto_correct: true

 config.vm.synced_folder ".", "/home/vagrant/solidus"
 config.ssh.forward_agent = true

 config.vm.provider "virtualbox" do |vb|
   vb.gui = false
   vb.memory = "2048"
   vb.cpus = 4
 end

  $SERVER_SETUP = <<-SCRIPT
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y expect
    apt-get install -y build-essential
    apt-get install -y libreadline6-dev
    apt-get install -y libyaml-dev
    apt-get install -y libpq-dev
    apt-get install -y autoconf
    apt-get install -y libgdbm-dev
    apt-get install -y libncurses5-dev
    apt-get install -y automake
    apt-get install -y libtool
    apt-get install -y bison
    apt-get install -y libffi-dev
    apt-get install -y postgresql-client
    apt-get install -y postgresql-contrib
    apt-get install -y npm
    apt-get install -y nodejs
    apt-get install -y nodejs-legacy
    apt-get -y install imagemagick
    apt-get -y install git
    apt-get -y install ruby-dev
    apt-get -y install ruby-execjs
    apt-get install -y virtualenvwrapper
    apt-get build-dep -y psycopg2
    apt-get build-dep -y pillow
    apt-get build-dep -y python-lxml
    apt-get install -y openjdk-7-jre-headless
    apt-get install -y wget
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
    echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list
    apt-get update
    apt-get install -y elasticsearch
    update-rc.d elasticsearch defaults 95 10
    service elasticsearch start
  SCRIPT


  $DATABASE_SETUP = <<-SCRIPT
    sudo -u postgres psql -c "CREATE ROLE vagrant WITH LOGIN SUPERUSER PASSWORD 'vagrant';"
    sudo -u postgres psql -c "CREATE ROLE solidus WITH LOGIN SUPERUSER PASSWORD 'solidus';"
    sudo -u postgres psql -c "CREATE DATABASE vagrant WITH OWNER vagrant;"
    sudo -u postgres psql -c "CREATE DATABASE solidus WITH OWNER solidus;"
  SCRIPT

  $RUBY_SPREE_SETUP = <<-SCRIPT
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    source /home/vagrant/.rvm/scripts/rvm
  SCRIPT

  $VIRTUALENV_SETUP = <<-SCRIPT
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    mkvirtualenv solidus
    workon solidus
  SCRIPT

  config.vm.provision "shell", inline: $SERVER_SETUP, privileged: true
  config.vm.provision "shell", inline: $DATABASE_SETUP, privileged: false
  config.vm.provision "shell", inline: $RUBY_SPREE_SETUP, privileged: false
  config.vm.provision "shell", inline: $VIRTUALENV_SETUP, privileged: false

end
