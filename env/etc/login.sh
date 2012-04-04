# this is the first thing sourced from profile.sh
# here we set up generic stuff that isn't specific to studio workflow
# this will only ever be sourced once

export OS=`uname`
export ARCH=`uname -m`
# no coredumps
ulimit -S -c 0
# files are read-only for other
# set this to 022 if you want files to be read-only for group and other
umask 002

#HOME=${HOME:-/home/`whoami`}

# bash dereferences the home directory if it is a link
# here you can translate the dereferenced path back to the "real" path
# for example, if /home gets dereferenced to /fileserver/net/home, you'd use this:
#export PWD=`pwd`
#cd ${PWD##/fileserver/net}
#export OLDPWD=$PWD

# save the path in DEFAULT_PATH to prevent ever-expanding PATH variables. 
export DEFAULT_PATH=$PATH

# Set the user prompt and window titlebar.
export PS1="\[\e]2;\u@\H \a\e[1m\]\w $\[\e[0m\] "

export MANPAGER=less
export SHELL=/bin/bash

if [ "$OS" = "Darwin" ]; then
    export TMPDIR=/tmp
else
    export TMPDIR=/usr/tmp
fi

# globals
export ENV_DIR=$HOME/workspace/carey/cmgmt/env
export ENV_SCRIPTS_DIR=${ENV_DIR}/scripts
export ENV_ETC_DIR=${ENV_DIR}/etc

# Continue sourcing the environment. 
source ${ENV_ETC_DIR}/studio.sh
