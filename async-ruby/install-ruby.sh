echo "[*] Before we can get started, we need to install Ruby!"
echo "[*] Adding required GPG key:"
apt install gnupg2 -y && gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
echo "[*] Downloading the Ruby Version Manager (rvm) and Ruby:"
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
clear
echo "Done installing Ruby!"
ruby -v
