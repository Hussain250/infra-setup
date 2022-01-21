#-----------------------------------------------------------------------------------------------#
# Setup infrastructure on ubuntu 20.04
# Mohammed Hussain
# 20-jan-22 
#-----------------------------------------------------------------------------------------------#

sudo apt-get update
sudo apt-get -y install python-pip
sudo pip install speedtest-cli 
sudo dpkg -i libsimplelog1_1.0.0_amd64.deb
sudo apt-get -y install libdaemon0
sudo apt-get -y install libev4
sudo dpkg -i tcp-intercept_1.1.1_amd64.deb
