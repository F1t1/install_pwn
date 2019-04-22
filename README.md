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
- Add BurpSuite Pro to custom file.
- Add SalseoTools to custom file.
