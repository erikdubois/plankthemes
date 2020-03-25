#!/usr/bin/bash

# Do not forget ending the path with '/'
plank_theme_dir=/usr/share/plank/themes/

echo "Using theme directory: "
echo $plank_theme_dir

# Find all directories not named .git within this directory, then add a destination string, add tabs, split on tabs, then quote string in a command for links into install-plank-theme-links.sh
find `pwd` -mindepth 1 -maxdepth 1 -type d | \
	 egrep -v '.git' | \
	 awk -v awk_plank_theme_dir=$plank_theme_dir --field-separator='/' '{ print $0 "\t\t" awk_plank_theme_dir $NF }' | \
	 awk --field-separator='\t\t' $'{ print "if [ -e $\'" $2 "\' ]; then echo $\'" $2 " already exists.\'; else ln -s $\'" $1 "\' " "$\'" $2 "\'; fi"  } ' > install-plank-theme-links.sh

# Find all directories not named .git within this directory, then add a destination string, add tabs, split on tabs, then quote string in a command for unlinking into uninstall-plank-theme-links.sh
find `pwd` -mindepth 1 -maxdepth 1 -type d | egrep -v '.git' | \
	awk -v awk_plank_theme_dir=$plank_theme_dir --field-separator='/' '{ print awk_plank_theme_dir $NF }' | \
	awk $'{ print "unlink $\'" $0 "\'"  } ' > uninstall-plank-theme-links.sh

# Make sh scripts install
chmod u+x install-plank-theme-links.sh
chmod u+x uninstall-plank-theme-links.sh

echo "Install script: ./install-plank-theme-links.sh"
echo "Uninstall script: ./uninstall-plank-theme-links.sh"
