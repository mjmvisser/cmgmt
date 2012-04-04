# stuff specific to projects goes here

export PROJECT_DIR=$PROD_DIR/$PROJECT

# source project overrides -- which may include app version overrides
if [[ -d "$PROJECT_DIR/etc/" ]]; then
    for f in "$PROJECT_DIR/etc/*.sh" ; do
        if [[ -r "$f" ]]; then
            . "$f"
        fi
    done
fi

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
