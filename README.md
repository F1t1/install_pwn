# install_pwn
Script to automate Kali VM initial useful tools instalation.

# Prerequisites
- sudo chmod 700 install_pwn.sh
- sudo chown root:root install_pwn.sh

# Usage
sudo ./install_pwn.sh

# Description
This script has been developed and tested on Kali Linux and has basically two main parts:
- Verification: 
  > - Checks integrity of each input file via md5sum.
  > - Checks script owner and privs.
  > - Checks running privs.

- Installation:
  > - Apt update and upgrade.
  > - APT-packages installation.
  > - Cloning of github repositories.
  > - Custom installations.

# TODO
- Add pwntools (custom) (http://docs.pwntools.com/en/stable/install.html)
- Add gobuster (wtf! no by default?!?!) (apt)
- Add dbeaver (apt)
- ~~Add terminator (apt)~~ done
- ~~Add bloodhound (apt)~~ done
- ~~Add evil-winrm (custom)~~ done
- ~~Add ~/.vimrc (set mouse-=a) to disable visual insert.~~ done
- ~~Add cewl (apt)~~ done
- ~~Add sublime text (custom) (http://tipsonubuntu.com/2017/05/30/install-sublime-text-3-ubuntu-16-04-official-way/)~~
- ~~Fix gdb-peda (custom) to modify .gdbinit in every user.~~ no needed.
- Add BurpSuite Pro to custom file.
- Add SalseoTools to custom file.
- Solve problems with exiftools (custom file)
- ~~Add Filezilla.~~ done
- ~~Add .tmux.conf~~ done
- ~~Add docker and wpscan docker~~ not needed. wpscan working again
- ~~Add vbox guest additions (apt)~~ migrated to vmware, no needed anymore
- ~~Add cifs-utils (apt)~~ done
- Add mozilla plugins
  - Cookie manager
  - Foxy proxy
  - Wappalizer
  - firefox multi account containers
