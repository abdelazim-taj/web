# -*- mode: ruby -*-
# vi: set ft=ruby :

$script_provision = <<SCRIPT
  sudo apt-add-repository -y ppa:brightbox/ruby-ng
  sudo apt-get -y update
  sudo apt-get -y install curl git-core python-software-properties ruby-dev libpq-dev build-essential autoconf bison libsqlite3-0 libsqlite3-dev libxml2 libxml2-dev libxslt1-dev nodejs postgresql postgresql-contrib libffi-dev imagemagick libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libgdbm3 libgdbm-dev ruby2.5 ruby2.5-dev npm

  sudo update-alternatives --set ruby /usr/bin/ruby2.5
  sudo update-alternatives --set gem /usr/bin/gem2.5
  sudo gem install bundler --no-ri --no-rdoc
  sudo npm config set strict-ssl false
  sudo npm install -g n
  sudo n stable
  sudo chown -R $USER: ~/
  sudo npm install -g yarn

  sudo -u postgres createdb --locale en_US.utf8 --encoding UTF8 --template template0 development
  sudo -u postgres createdb --locale en_US.utf8 --encoding UTF8 --template template0 test
  echo "ALTER USER postgres WITH PASSWORD \'develop\';" | sudo -u postgres psql

  cd /vagrant
  sudo chown -R $USER: ~/
  yarn install
  sudo chown -R $USER: ~/
  bundle
  rails db:migrate db:seed

SCRIPT

$script_up = <<SCRIPT
  cd /vagrant
  rails s
SCRIPT

Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'MEC-surveys-box'
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 3035, host: 3035 # port for webpacker server
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
  end
  config.vm.provision :shell, privileged: false, inline: $script_provision
  # config.vm.provision :shell, privileged: false, inline: $script_up, run: 'always'
end