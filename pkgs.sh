#!/bin/env bash

# Take input from user
pkgname=$(gum input --prompt "Packagename > " --placeholder "Which package do you want to install? ")

# Prompt user to choose
echo "Should $pkgname be installed from source or using a package manager?"
pkgsource=$(gum choose --limit=1 "Source" "Package manager")
pkgsource=${pkgsource:-"Package manager"}
pkgsource=${pkgsource::1}

pkguri=$(gum input --prompt "Url > " --placeholder "The url for the package")

# Check the permissions for /usr/local/src
#usrpermbits=$(stat -c "%a" /usr/local/src)
