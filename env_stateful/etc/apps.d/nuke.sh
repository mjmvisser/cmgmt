if [ -z "$NUKE_VERSION" ]; then
    echo "NUKE_VERSION is not set!"
    return
fi

if [ "$OS" = "Linux" ]; then
    export MAYA_LOCATION=/usr/autodesk/maya$MAYA_VERSION-x64
elif [ "$OS" = "Darwin" ]; then
    export MAYA_LOCATION=/Applications/Autodesk/maya$MAYA_VERSION/Maya.app/Contents
fi
