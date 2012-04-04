# this is where we set up studio-specific stuff
# this may be sourced multiple times

# set default versions
MAYA_VERSION=2012

# source aliases
. $ENV_ETC_DIR/alias.sh

# default versions
MAYA_VERSION=2011
NUKE_VERSION=6.3v2

# default project
PROJECT=default

. $ENV_ETC_DIR/project.sh

# source app setup
for app in $ENV_ETC_DIR/apps.d/*.sh ; do
    if [ -r "$app" ]; then
        . $app
    fi
done

# Souce the user's custom environment settings.
if [ -e $HOME/.bashrc ] ; then
    . $HOME/.bashrc
fi
