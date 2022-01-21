#-----------------------------------------------------------------------------------------------#
# Setup infrastructure on ubuntu 20.04
# Mohammed Hussain
# 20-jan-22 
#-----------------------------------------------------------------------------------------------#

sudo apt-get update
sudo apt-get -y install python-pip
sudo pip install speedtest-cli 
sudo dpkg -i linux-image-3.18.20-watchy_3.18.20-1_amd64.deb
sudo update-grub
sudo apt-get install libdb5.1
sudo dpkg -i iproute2_4.0.89-0-1_amd64.deb
