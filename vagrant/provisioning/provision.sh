#!/bin/bash

################################################################################
# NOTE THAT ALL COMMANDS IN THIS FILE ARE RUN AS ROOT THUS SUDO IS UNNECESSARY #
################################################################################

# Basic Setup
apt-get -y update
apt-get -y install curl git zsh

# Postgres setup
apt-get -y install postgresql postgresql-client-common postgresql-client-9.1 pgadmin3 libpq-dev
sed -r "s/^local\s+all\s+all\s+peer$/local all all  md5/" /etc/postgresql/9.1/main/pg_hba.conf > /.temppg_conf
mv /.temppg_conf /etc/postgresql/9.1/main/pg_hba.conf
su vagrant
sudo /etc/init.d/postgresql start
echo "CREATE USER weedout WITH PASSWORD 'insecure';
      CREATE DATABASE weedout_development;
      GRANT ALL PRIVILEGES ON DATABASE weedout_development TO weedout;" | sudo -u postgres psql -f-

# RVM
\curl -L https://get.rvm.io | 
  bash -s stable --ruby --autolibs=enable --auto-dotfiles
source /usr/local/rvm/scripts/rvm
rvm requirements

# Ruby
rvm install ruby
rvm use ruby --default

# Ruby gems
rvm rubygems current

# Rails
gem install rails --version 4.0.0 --no-ri --no-rdoc

# Link the rails app to be in the home directory
ln -fs /vagrant_weedout /home/vagrant/weedout

# Set up oh my zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
echo "export PATH=\$PATH:$PATH" >> /home/vagrant/.zshrc
sed -i "s/robbyrussell/frisk/" /home/vagrant/.zshrc
chsh -s /usr/bin/zsh vagrant

# Set up the rails project
cd /home/vagrant/weedout
bundle install
rake db:migrate
