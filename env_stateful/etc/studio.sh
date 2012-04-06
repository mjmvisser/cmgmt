# this is where we set up studio-specific stuff
# this may be sourced multiple times

# globals
export PROD_DIR=/tmp/prod
export OCIO=/Volumes/Om/Users/mark/workspace/carey/cmgmt/spi-vfx/config.ocio

# reset path
export PATH=$DEFAULT_PATH

# aliases
. "$ENV_ETC_DIR/alias.sh"

# misc functions
. "$ENV_ETC_DIR/functions.sh"

# default versions
export MAYA_VERSION=2011
export NUKE_VERSION=6.3v2

# default project
if [ -r "$HOME/.state" ]; then
    . "$HOME/.state"
else
    # minimal state for defaults
	export PROJECT=default
	unset SEQ SHOT TYPE ASSET DEPT 
fi

# project setup (including asset/sequence/shot/work/etc)
. "$ENV_ETC_DIR/project.sh"

# user's custom environment settings.
# this may include specific app version overrides, so we source it
# before app setup
# if login.sh is sourced FROM $HOME/.bashrc, replace this with 
# $HOME/.config
if [ -e "$HOME/.bashrc" ] ; then
    . "$HOME/.bashrc"
fi

# source app setup
for app in "$ENV_ETC_DIR/apps.d/*.sh" ; do
    if [ -r "$app" ]; then
        . "$app"
    fi
done
