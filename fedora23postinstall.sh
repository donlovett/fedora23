!/bin/bash
#################################################
# Post Installation Installations Fedora 23 Gnome3 
#################################################
function doWork() {

START_TIME=$SECONDS

echo "${yellow} $SECONDS ${reset}"
# Set colors for echo command
yellow=`tput setaf 3`
cyan=`tput setaf 6`
white=`tput setaf 7`

# update packages
sudo dnf -y update

# set the hostname
echo "${yellow} "Setting the host name" ${reset}"
sudo hostnamectl set-hostname --static dondesk.projectbits.com
echo "${white} "Host Name Set" ${reset}"

#Activate RPMFusion repo
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm

# "Install Google Chrome"
echo "${yellow} "Install Google Chrome" ${reset}"
#gedit /etc/yum.repos.d/google-chrome.repo
#[google-chrome]
#name=google-chrome
#baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
#enabled=1
#gpgcheck=1
#gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

#  Create google-chrome.repo file  #
sudo touch /etc/yum.repos.d/google-chrome.repo

# Past google chrome repo content #
if test ! -f /etc/yum.repos.d/google-chrome.repo
then
echo File does not exit
echo "Creating file for Google Chrome Repo..."
sudo wget https://github.com/donlovett/fedora23/blob/master/google-chrome.repo -O /etc/yum.repos.d/google-chrome.repo
else
echo File exit. Do Nothing.
fi

#  Install google chrome browser  #
sudo dnf install google-chrome-stable


echo "${white} "Chrome Installed" ${reset}"

# Install rar and zip utilities
sudo dnf -y install unzip 

# Let's Communicate
sudo dnf -y install pidgin

# install VirtualBox
sudo dnf -y install VirtualBox

# install the XFCE4 desktop
sudo dnf -y groupinstall xfce-desktop

# open standard RDP ports
sudo firewall-cmd --add-port=3389/tcp
sudo firewall-cmd --permanent --add-port=3389/tcp

# install TigerVNC and xRDP
sudo dnf -y install tigervnc tigervnc-server
sudo dnf -y install xrdp

# stop disabling SELinux
sudo chcon --type=bin_t /usr/sbin/xrdp
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman

# enable xRDP service
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman

# start xRDP service
sudo systemctl start xrdp-sesman
sudo systemctl start xrdp.service

# set XFCE4 desktop for RDP connections
sudo echo "startxfce4" > ~/.Xclients
sudo chmod +x ~/.Xclients
sudo systemctl restart xrdp.service

# install Ansible
sudo dnf -y install ansible

# Set the time of the system
# install ntpdate
sudo dnf -y install ntpdate
sudo dnf install ntpdate
sudo ntpdate 0.fedora.pool.ntp.org
# set the hardware clock to the local time
sudo hwclock --systohc --localtime


# Install filezilla
sudo dnf -y install filezilla

# Download latest Skype rpm file #
echo "Download latest Skype rpm file"
if test ! -f skype-4.3.0.37-fedora.i586.rpm
then
echo File does not exit
echo "Downloading file for Skype..."
sudo wget http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm
else
echo File exit. Do Nothing.
fi


#sudo wget http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm

# Install Skype, This will install dependencies 
echo "Install latest Skype rpm file"
#
sudo dnf -y install skype-4.3.0.37-fedora.i586.rpm

# For 64-bit system install below dependencies #
sudo dnf -y install libXv.i686 libXScrnSaver.i686 qt.i686 qt-x11.i686 pulseaudio-libs.i686 pulseaudio-libs-glib2.i686 alsa-plugins-pulseaudio.i686

# If you don't need firewall you can disable it.

sudo systemctl stop firewalld
sudo systemctl disable firewalld rolekit 

#Installing Fedy is very simple, just do:
sudo -c "curl http://folkswithhats.org/fedy-installer -o fedy-installer"
sudo chmod +x fedy-installer
sudo ./fedy-installer

#Instll VNC Server for GUI access from a remote client.
#sudo dnf -y install tigervnc-server 
# Set VNC password using user account you'll be connecting to from a remote machine
# sudo vncpasswd "denver" 
# Start VNC server by running below command.
#sudo vncserver :1 -geometry 800x600 -depth 24 

# Install Gnome Tweek tool
sudo dnf -y install gnome-tweak-tool

# Install git
sudo dnf -y install git
sudo git --version
# Configuration To prevent any commit errors, it’s a good idea to set up your user for git (use the –global option to specify global configuration settings).
git config --global user.name "yourname"
git config --global user.email "your name"
git config --list

# install grub customizer
sudo dnf -y install grub-customizer

# Install Eclipse Mars
sudo dnf -y install eclipse

#Start ssh on boot
sudo dnf -y install openssh-server

#Then, start the sshd service and make it automatically start next time you boot by

sudo systemctl start sshd.service
sudo systemctl enable sshd.service

# Install Identify Policy and Audit server
sudo dnf -y install freeipa-server

# Install Subversion
sudo dnf -y install svn

# install RabbitVCS SVN Client
sudo dnf -y install rabbitvcs*

#Install Acrobat
sudo dnf -y install libatk-1.0.so.0 
sudo dnf -y install libgdk_pixbuf-2.0.so.0 
sudo dnf -y install libgdk_pixbuf_xlib-2.0.so.0
sudo dnf -y install libgdk-x11-2.0.so.0
sudo dnf -y install libGLU.so.1
sudo dnf -y install libgtk-x11-2.0.so.0
sudo dnf -y install libpangox-1.0.so.0
sudo dnf -y install libXt.so.6

echo "Download Acrobat rpm file"
if test ! -f AdbeRdr9.5.5-1_i486linux_enu.rpm
then
echo File does not exit
echo "Downloading file for Skype..."
sudo wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i486linux_enu.rpm
else
echo File exit. Do Nothing.
fi

#sudo wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i486linux_enu.rpm

sudo rpm -ivh AdbeRdr9.5.5-1_i486linux_enu.rpm 


ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo ${cyan}  "$(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"  

  
    echo "Hello world"
  
echo "${white} "Script Complete" ${reset}"
}
  
doWork | tee logfile
