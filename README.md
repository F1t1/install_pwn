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
- Add cewl (apt)
- Fix gdb-peda (custom) to modify .gdbinit in every user.
- Add BurpSuite Pro to custom file.
- Add SalseoTools to custom file.
- Solve problems with exiftools (custom file)
- ~~Add Filezilla.~~ done
- ~~Add .tmux.conf~~ done
- ~~Add docker and wpscan docker~~ not needed. wpscan working again
- ~~Add vbox guest additions (apt)~~ done
- ~~Add cifs-utils (apt)~~ done
- Add mozilla plugins
  - Cookie manager
  - Foxy proxy
  - Wappalizer
