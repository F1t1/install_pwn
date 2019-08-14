#!/bin/sh

RED='\e[00;31m'
GREEN='\e[00;32m'
YELLOW='\e[00;33m'
BLUE='\e[00;34m'
CYAN='\e[00;36m'
DEFAULT='\e[0m'


header(){
	#################
	# Initial banner
	# CALL: header()
	#################
	
	echo "$YELLOW------------------------------------------------------------------"
	echo "-----------------------INSTALL PWN--------------------------------"
	echo "------------------------------------------------------------------"
	echo "------- Bash script to auto install all the shit you need --------"
	echo "------------------------------------------------------------------$DEFAULT"
}

footer(){
	#################
	# End of the script
	# CALL: footer()
	#################
	
	echo "$YELLOW------------------------------------------------------------------"
	echo "-------------------- SCRIPT FINISHED -----------------------------"
	echo "------------------------------------------------------------------$DEFAULT"
}

install_apt(){
	#################
	# Installs apt-package and redirects stderr to ErrorFile.log
	# CALL: install_apt($package)
	#################
	
	echo "$CYAN[*] ---- Installing $1 via APT -----$DEFAULT" | tee -a LogFile.log
	(apt-get install $1 -y 2>> LogFile.log) || echo "$RED[-] Found some errors installing $1."
	echo "$GREEN[+] -------- $1 installed ----------$DEFAULT" | tee -a LogFile.log
}

clean_github(){
	#################
	# Cleans a local github repo and redirects stderr to ErrorFile.log
	# CALL: clean_github($name)
	#################
	echo "$GREEN[+] Deleting previous installation of $1...$DEFAULT" | tee -a LogFile.log
	rm -rf "/usr/share/$1" 2>> LogFile.log
}

install_github(){
	#################
	# Clones a github repo and redirects stderr to ErrorFile.log
	# CALL: install_github($git, $name)
	#################
	echo "$CYAN[*] ---- Cloning $2 via github --------$DEFAULT" | tee -a LogFile.log
	(git clone $1 "/usr/share/$2" 2>> LogFile.log) || echo "$RED[-] Error cloning $1.$DEFAULT"
	echo "$GREEN[+] -------- $2 installed ----------$DEFAULT" | tee -a LogFile.log
}

install_custom(){
	#################
	# Executes custom commands and redirects stderr to ErrorFile.log
	# CALL: install_custom($command $directory)
	#################
	echo "$CYAN[*] Received command >> $1." | tee -a $directory/LogFile.log
	echo "$CYAN[*] Executing...$DEFAULT" | tee -a $directory/LogFile.log
	$1 2>> $directory/LogFile.log
	echo "$GREEN[+] Done!$DEFAULT" | tee -a $directory/LogFile.log
}

verify_files(){
	#################
	# Calculates md5sum of each input file and compares them with saved values to check integrity.
	# CALL: verify_files($packages_file $github_file $custom_file)
	#################
	
	#Expected values
	md5_packages="e6409cd419e5c8f59dcc2e9e2d4aba29"
	md5_github="fdd62876969e937c9eca1894617a009f"
	md5_custom="4d1d46a1a9f02980d5fed47032209421"
	
	#Current values
	current_md5_packages=$(md5sum $1 | cut -d ' ' -f 1)
	current_md5_github=$(md5sum $2 | cut -d ' ' -f 1)
	current_md5_custom=$(md5sum $3 | cut -d ' ' -f 1)

	all_good=1

	if [ "$current_md5_packages" != "$md5_packages" ] 
	then 
		echo "Packages file:$RED [ERROR]$DEFAULT"
		all_good=0
	else
		echo "Packages file:$GREEN [OK]$DEFAULT"
	fi
	if [ "$current_md5_github" != "$md5_github" ] 
	then       
		echo "Github file:$RED [ERROR]$DEFAULT"
		all_good=0
	else
		echo "Github file:$GREEN [OK]$DEFAULT"
	fi
	if [ "$current_md5_custom" != "$md5_custom" ]
	then
		echo "Custom file:$RED [ERROR]$DEFAULT"
		all_good=0
	else
		echo "Custom file:$GREEN [OK]$DEFAULT"
	fi
	
	if [ $all_good -eq 0 ]
	then
		echo "$RED[ERROR] Input files have been modified."
		echo "Program is exiting now...$DEFAULT"
		exit
	fi
}

check_privs(){
	################
	# Checks if file's owner is root and file's privs (need to be 700 or 744). In other case, shows an error message.
	# CALL: check_privs($this_script)
	################
	user=$(whoami)
	if [ "$user" != "root" ]
	then
		echo "$RED ERROR: Script needs to be executed as root.$DEFAULT"
		echo "Usage: sudo $1"
		exit
	fi
	
	privs=$(ls -la $1 | cut -d ' ' -f 1)
	if [ "$privs" != "-rwx------" ] && [ "$privs" != "-rwxr--r--" ]
	then
		echo "$RED ERROR: Wrong permisions."
		echo "Use 'sudo chmod 700 $1' or 'sudo chmod 744' before executing.$DEFAULT"
		exit
	fi

	owner=$(ls -la $1 | cut -d ' ' -f 3)
	group=$(ls -la $1 | cut -d ' ' -f 4)
	if [ "$owner" != "root" ] || [ "$group" != "root" ]
	then
		echo "$RED ERROR: Wrong owner."
		echo "Use 'sudo chown root:root $1' before executing. $DEFAULT"
		exit
	fi
}

#######################
# MAIN BODY
#######################

#Security checks
check_privs $0

packages_file="./packages"
github_file="./github"
custom_file="./custom"

verify_files $packages_file $github_file $custom_file

header
rm ./LogFile.log #Delete previous execution logs.

echo "$CYAN[*] UPDATING APT...$DEFAULT" | tee -a LogFile.log
apt-get update && apt-get upgrade -f -y
echo "$CYAN[*] INSTALLING APT-PACKAGES...$DEFAULT" | tee -a LogFile.log
while IFS= read -r package
do
	install_apt $package
done < "$packages_file"

echo "$CYAN[*] CLONING GITHUB REPOS...$DEFAULT" | tee -a LogFile.log
while IFS= read -r repo
do
	name="$(echo $repo | cut -d ';' -f 1)"
	package="$(echo $repo | cut -d ';' -f 2)"
	clean_github $name
	install_github $package $name
done < "$github_file"

echo "$CYAN[*] INSTALLING TOOLS WITH CUSTOM INSTALLATION...$DEFAULT" | tee -a LogFile.log
while IFS= read -r custom
do
	directory=$(pwd)
	echo "$CYAN[*] ---- Custom installation of $custom in progress -----$DEFAULT" | tee -a LogFile.log
	ended=1
	counter=1
	while [ $ended -gt 0 ]
	do
		current_command=$(echo $custom | cut -d ';' -f $counter)
		if [ -z "$current_command" ]
		then
			ended=0
		else
			#IMPORTANT: Call this function with param between quotes to be considered as ONLY ONE param.
			install_custom "$current_command" $directory
			counter=$(( $counter + 1 ))
		fi
	done
	cd $directory
	echo "$GREEN[*] ---- Custom tool installed -----$DEFAULT" | tee -a LogFile.log
done < "$custom_file"

footer
