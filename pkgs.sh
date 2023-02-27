#!/bin/env bash

srcdir=/usr/local/src/

# Take input from user
pkgname=$(gum input --prompt "Packagename > " --placeholder "Which package do you want to install? ")

# Prompt user to choose
echo "Should $pkgname be installed from source or using a package manager?"
pkgsource=$(gum choose --limit=1 "Source" "Package manager")
pkgsource=${pkgsource:-"Package manager"}
pkgsource=${pkgsource::1}

pkguri=$(gum input --prompt "Url > " --placeholder "The url for the package")

# Check the permissions for /usr/local/src
usrpermbits=$(stat -c "%a" $srcdir)


if [ $usrpermbits -ne 777 ]; then
    chmod 0777 $srcdir
fi

bname=$(basename $pkguri)


# Don't download if the file doesn't exist
if ! [ -f $srcdir/$bname ]; then
    wget -t 3 $pkguri -P $srcdir
    if [ $? -ne 0 ]; then
        echo "The installation was not sucessful... Download Failed"
	exit 1
    fi
fi

cd $srcdir
if [ "$pkgsource" == "S" ]; then
    tar xvf $bname
    cd $(echo "$bname" | sed s/.tar.*//g)
    ./configure
    make
    checkinstall
    installstatus=$?
else
    if [[ "$bname"  =~ .*".rpm" ]]; then
        alien -ki $bname
        installstatus=$?
    else
        dpkg --install $bname || apt-get --fix-broken install
        installstatus=$?
    fi
fi

if [ $installstatus -eq 0 ]; then
    echo "The installation was successful"
else
   echo "There was errors during the installation... Exited with $installstatus"
fi
