# stuff specific to projects goes here

export PROJECT_DIR=$PROD_DIR/$PROJECT

unset SEQ_DIR SHOT_DIR TYPE_DIR ASSET_DIR DEPT_DIR WORK_DIR

if [[ -n "$SEQ" ]]; then
    export SEQ_DIR=$PROJECT_DIR/seq/$SEQ
    export WORK_DIR=$SEQ_DIR
    
    if [[ -n "$SHOT" ]]; then
        export SHOT_DIR=$SEQ_DIR/$SHOT
        export WORK_DIR=$SHOT_DIR
        
        if [[ -n "$DEPT" ]]; then
            export DEPT_DIR=$SHOT_DIR/$DEPT
            export WORK_DIR=$DEPT_DIR
        fi
    fi
elif [[ -n "$TYPE" ]]; then
    export TYPE_DIR=$PROJECT_DIR/seq/$TYPE
    export WORK_DIR=$TYPE_DIR
    
    if [[ -n "$ASSET" ]]; then
        export ASSET_DIR=$TYPE_DIR/$ASSET
        export WORK_DIR=$ASSET_DIR
        
        if [[ -n "$DEPT" ]]; then
            export DEPT_DIR=$ASSET_DIR/$DEPT
            export WORK_DIR=$DEPT_DIR
        fi
    fi
fi

# source overrides -- which may include app version overrides
# WARNING: make sure any overrides are cleared in studio.sh, or they
# will be sticky!
# order is important here
for var in PROJECT_DIR SEQ_DIR TYPE_DIR SHOT_DIR ASSET_DIR DEPT_DIR; do
    config=${!var}/.config
	if [[ -r "$config" ]]; then
        . "$config"
	fi
done
