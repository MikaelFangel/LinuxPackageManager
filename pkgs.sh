#!/bin/sh

# Take input from user
pkgname=$(gum input --prompt "Packagename > " --placeholder "Which package do you want to install? ")

# Prompt user to choose
echo "Should $pkgname be installed from source or using a package manager?"
pkgsource=$(gum choose --limit=1 "Source" "Package manager")

echo $pkgsource



#read -p "Should $pkgname be installed from source (s) og using a package manager (p)? [P|s] " pkgsource

# Ensure that that it is always lower case and that the variable is always set
#pkgsource=$(echo ${pkgsource:-p} | awk '{print tolower($0)}')
#read -p "The URL for the package: " pkguri

# Check the permissions for /usr/local/src
#usrpermbits=$(stat -c "%a" /usr/local/src)
