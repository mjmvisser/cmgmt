if [ -z "$MAYA_VERSION" ]; then
    echo "MAYA_VERSION is not set!"
    return
fi

if [ "$OS" = "Linux" ]; then
    export MAYA_LOCATION=/usr/autodesk/maya$MAYA_VERSION-x64
elif [ "$OS" = "Darwin" ]; then
    export MAYA_LOCATION=/Applications/Autodesk/maya$MAYA_VERSION/Maya.app/Contents
fi

export PATH=$PATH:$MAYA_LOCATION/bin
export LM_LICENSE_FILE=${LM_LICENSE_FILE:+$LM_LICENSE_FILE:}7111@licmaya

# default maya project
export MAYA_APP_DIR=$HOME/maya
