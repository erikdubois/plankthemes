#!/usr/bin/bash
# Find all directories not named .git within this directory, then add a destination string, add tabs, split on tabs, then quote string in a command for links into install-plank-theme-links.sh
find `pwd` -mindepth 1 -maxdepth 1 -type d | egrep -v '.git' | awk --field-separator='/' '{ print $0 "\t\t/usr/share/plank/themes/" $NF }' | awk --field-separator='\t\t' $'{ print "ln -s $\'" $1 "\' " "$\'" $2 "\'"  } ' > install-plank-theme-links.sh
# Find all directories not named .git within this directory, then add a destination string, add tabs, split on tabs, then quote string in a command for unlinking into uninstall-plank-theme-links.sh
find `pwd` -mindepth 1 -maxdepth 1 -type d | egrep -v '.git' | awk --field-separator='/' '{ print $0 "\t\t/usr/share/plank/themes/" $NF }' | awk --field-separator='\t\t' $'{ print "unlink $\'" $2 "\'"  } ' > uninstall-plank-theme-links.sh
# Make sh scripts install
chmod u+x install-plank-theme-links.sh
chmod u+x uninstall-plank-theme-links.sh
