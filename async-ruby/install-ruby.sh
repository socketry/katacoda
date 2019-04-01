echo "[*] Before we can get started, we need to install Ruby!"
sleep 3

echo "[*] Downloading required packages (curl / gnupg2):"
apt install curl gnupg2 -y

echo "[*] downloading the ruby version manager (rvm) and ruby:"
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm

clear

echo "Done installing Ruby!"
ruby -v
