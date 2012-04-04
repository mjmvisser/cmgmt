# stuff specific to projects goes here

export PROJECT_DIR=/prod/$PROJECT

# source project overrides -- which may include app version overrides
if [ -d "$PROJECT_DIR/etc/" ]; then
    for f in $PROJECT_DIR/etc/*.sh ; do
        if [ -r "$f" ]; then
            . $f
        fi
    done
fi
