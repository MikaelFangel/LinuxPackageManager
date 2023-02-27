# LinuxPackageManager
A packagement script written as a part of  the DTU course Linux Server and Network

The script helps installing packages from source, .deb or .rpm through a url to the package. The installer assumes that its run on a debian based system with dpkg and apt available. It also assumes that packages from source a tarballs and packagede using gnu autotools.

## Dependencies 
 - gum
 - wget
 - alien (if installing .rpm)
 - checkinstall
 - build-essential 