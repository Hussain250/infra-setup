#-----------------------------------------------------------------------------------------------#
# Setup infrastructure on ubuntu 20.04
# Mohammed Hussain
# 20-jan-22 
#-----------------------------------------------------------------------------------------------#

INST_DIR='/home/ubuntu/temp/cloud-maxwell/'i
HOME_DIR='/home/ubuntu/'
KEY_PATH='/tmp/'

function install_maxwell
{
	general_update_install  	#general update, pyhton-pip, speedtest, monit
	install_kernel			#install mptcp kerenl
	install_iproute_packages	#install iproute & depencies
	install_libsimplog		#install libsimplelog
	install_tcpintercept		#install tcp intercept & dependencies
	install_openvpn			#install openvpn & depencies
	config_openvpn			#copy the openvpn files to the openvpn directory
	update_grub                     #update mptcp kernel
	maxwell_folder			#copying script files and other folders
	rem_update_repo			#adding zifilink update repo
	version_check			#cross check the all the installed debs
	reboot				#rebooting the server & removing the installing folder
}

function general_update_install
{
	echo "> General update"
	sudo apt-get update
	echo
	echo "> Installing Python-Pip..."
	sudo apt-get -y install python-pip
	echo
	echo "> Installing speedtest app..."
	sudo pip install speedtest-cli
	echo
	echo "> Installing Monti..."
	sudo apt-get -y install monit
	echo "> Installing trach-cli..."
	sudo apt-get -y install trash-cli
	echo "> Installing fail2ban..."
	sudo apt-get -y install fail2ban
	echo "> Installing python-apt..."
	sudo apt-get -y install python-apt
	echo "> Installing htop..."
	sudo apt-get -y install htop
	echo "> Installing iftop..."
	sudo apt-get -y install iftop
	echo "> Installing bwm-ng..."
	sudo apt-get -y install bwm-ng
	echo "> installing aws s3smd..."
	sudo apt-get install s3cmd
}


function install_kernel
{
	cd $INST_DIR
	echo "> MPTCP Kernel..."
	sudo dpkg -i linux-image-3.18.20-watchy_3.18.20-1_amd64.deb
	echo "> Updating grub..."
	sudo update-grub
}

function install_iproute_packages
{
	cd $INST_DIR
	echo "> installing Iprotue depencencies..."
	sudo apt-get install libdb5.1
	echo
	echo "> Installing IProute"
	sudo dpkg -i iproute2_4.0.89-0-1_amd64.deb
	echo
	echo "> Iproute installtion complete"
}

function install_libsimplog
{
	cd $INST_DIR
	echo "> installing libsimplelog..."
	sudo dpkg -i libsimplelog1_1.0.0_amd64.deb
	echo
	echo "> libsimplelog installtion compelte"
}

function install_tcpintercept
{
	cd $INST_DIR
    echo "> installing libdaemon..."
	sudo apt-get -y install libdaemon0
	echo
	echo "> installing libev4..."
    sudo apt-get -y install libev4
    echo
	echo "> installing tcp intercept..."
	sudo dpkg -i tcp-intercept_1.1.1_amd64.deb
    echo "> tcp intercept installtion compelte"
}

function install_openvpn
{
	cd $INST_DIR
	echo "> installing liblzo2-2 &  libpkcs11-helper1..."
	sudo apt-get -y install liblzo2-2
	sudo apt-get -y install libpkcs11-helper1
	sudo apt-get -f install
	echo
	echo "> installing openvpn ..."
	sudo dpkg -i openvpn_2.3.2-7ubuntu3.1_amd64.deb
	echo "> openvpn installing complete"
}


function config_openvpn
{
	cd $INST_DIR
	echo "> untaring ovpn folder..."
	tar -zxvf openvpn.tar.gz
	cd $INST_DIR/openvpn
	sudo cp -pr * /etc/openvpn/
	echo
	echo "> restarting the openvpn servrice..."
	sudo service openvpn restart

}

function version_check
{
	cd $HOME_DIR
	echo
	echo "----------------------"
	sudo dpkg -l iproute2*
	echo
	echo "----------------------"
	sudo dpkg -l tcp-intercept
	echo
	echo "----------------------"
	sudo dpkg -l openvpn
	echo
	echo "----------------------"
	sudo dpkg -l libsim*
	echo
	echo "----------------------"	
	lsb_release -a
	echo 
	echo "----------------------"

}

function update_grub
{
	echo "> changing grup loading" 
	#sudo sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT="1>2"/' /etc/default/grub
	sudo update-grub
	echo "> grub updated successfully"
}

function maxwell_folder
{
	cd $INST_DIR
	echo"> untaring maxwell folder..."
	tar -zxvf maxwell.tar.gz
	cd maxwell
	cd /opt/
	echo "> copying maxwell folder..."
	cp -r $INST_DIR/maxwell /opt/
	cd $INST_DIR
	echo "copying scripts files"
	sudo cp *.sh /opt/maxwell/
	echo "> setting exectution permission"
	sudo chmod +x set_*
	sudo chmod +x ip.sh
	sudo chmod +x maxwell_firewall
}

function rem_update_repo
{
        echo '> backuping source.list'
        sudo mv /etc/apt/sources.list /etc/apt/sources.list.original
       
	
}


function reboot
{
        echo '> removing the installtion folder from home directory'
        rm -rf /home/watchy/temp/
        echo '> i am planning to reboot. Do you agree it? (yes/no)'
        read CHOICE

        if [[ "$CHOICE" == "yes" ]]
        then
                sudo reboot
        elif [[ "$CHOICE" == "no" ]]
        then
                echo 'Ok. Then you reboot it manually but running *sudo reboot*'
        fi
}


install_maxwell

