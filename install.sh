#!/bin/bash

# installing dependencies
sudo apt install -y curl git wget gpg ca-certificates gnupg software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

# install zsh
sudo apt install -y zsh
chsh -s $(which zsh)

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o ~/.zshrc https://raw.githubusercontent.com/JustinByrne/dotfiles/main/.zshrc
curl -o ~/.zsh_aliases https://raw.githubusercontent.com/JustinByrne/dotfiles/main/.zsh_aliases

# install fira font
sudo apt install -y fonts-firacode

# install google chrome
curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/google-chrome-stable_current_amd64.deb
sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb
rm /tmp/google-chrome-stable_current_amd64.deb

# install vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
apt update
sudo apt install -y code

# install redis insight
curl https://download.redisinsight.redis.com/latest/RedisInsight-linux-amd64.deb -o /tmp/RedisInsight-linux-amd64.deb
sudo apt install -y /tmp/RedisInsight-linux-amd64.deb
rm /tmp/RedisInsight-linux-amd64.deb

# install php
sudo apt install -y \
    php8.1-bcmath php8.2-bcmath \
    php8.1-cli php8.2-cli \
    php8.1-common php8.2-common \
    php8.1-curl php8.2-curl \
    php8.1-fpm php8.2-fpm \
    php8.1-gd php8.2-gd \
    php8.1-igbinary php8.2-igbinary \
    php8.1-intl php8.2-intl \
    php8.1-mbstring php8.2-mbstring \
    php8.1-mysql php8.2-mysql \
    php8.1-opcache php8.2-opcache \
    php8.1-readline php8.2-readline \
    php8.1-redis php8.2-redis \
    php8.1-sqlite3 php8.2-sqlite3 \
    php8.1-xml php8.2-xml \
    php8.1-zip php8.2-zip
sudo update-alternatives --set php /usr/bin/php8.2

# install composer
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# install laravel installer
composer global require laravel/installer

# install nodejs & npm
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# install tableplus
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg > /dev/null
sudo add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main"
sudo apt update
sudo apt install tableplus

# install docker & docker desktop
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
curl https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.1-amd64.deb -o /tmp/docker-desktop-amd64.deb
sudo apt install -y /tmp/docker-desktop-amd64.deb
rm /tmp/docker-desktop-amd64.deb
sudo apt install -y golang-docker-credential-helpers
mkdir ~/.docker
echo "{
	\"credsStore\": \"pass\"
}" > ~/.docker/config.json

