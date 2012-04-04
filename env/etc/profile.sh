# /etc/profile.d/profile.sh
# This file initiates the setting of the environment.
# It should be sourced last by /etc/profile.

# Do not set up the environment if the user is root.
if [ ! ${UID} -eq 0 ] ; then    
    filename=/studio/custom/env/etc/login.sh

    if [ -e $filename ] ; then
        . $filename
    fi

    unset filename
fi
