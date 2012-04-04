
function print_usage ()
{
    echo "Usage: go SEQUENCE [SHOT [DEPT]]"
    echo "       go ASSET [TYPE [DEPT]]"
}

function _go()
{
    local cur prev cword
    
    COMPREPLY=()

    _get_comp_words_by_ref cur prev cword 

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-? -h' ) )
    elif [[ $cword = 1 ]]; then
        local seqs assets

        seqs=( $PROJECT_DIR/seq/$cur*/ )
        _dirnames seqs

        types=( $PROJECT_DIR/asset/$cur*/ )
        _dirnames types
        
        COMPREPLY=( ${seqs[@]} ${types[@]} )
        
    elif [[ $cword = 2 ]]; then
        local shots assets
        if [[ -d $PROJECT_DIR/seq/$prev ]]; then
            # we're going to a shot 
		    shots=( $PROJECT_DIR/seq/$prev/${cur}*/ )
		    _dirnames shots
		elif [[ -d $PROJECT_DIR/asset/$prev ]]; then
            # we're going to an asset 
		    assets=( $PROJECT_DIR/asset/$prev/${cur}*/ )
		    _dirnames assets
		fi

        COMPREPLY=( ${shots[@]} ${assets[@]} )
        
    elif [[ $cword = 3 ]]; then
        local shot_depts asset_depts
        if [[ -d $PROJECT_DIR/seq/${COMP_WORDS[1]}/${COMP_WORDS[2]} ]]; then
        	shot_depts=( $PROJECT_DIR/seq/${COMP_WORDS[1]}/${COMP_WORDS[2]}/$cur*/ )
        	_dirnames shot_depts
        elif [[ -d $PROJECT_DIR/asset/${COMP_WORDS[1]}/${COMP_WORDS[2]} ]]; then
		    asset_depts=( $PROJECT_DIR/asset/${COMP_WORDS[1]}/${COMP_WORDS[2]}/${cur}*/ )
		    _dirnames asset_depts
		fi
        
        COMPREPLY=( ${shot_depts[@]} ${asset_depts[@]} )
    fi
} && complete -F _go go


#
# main
#

if [[ "$1" = "-?" || "$1" = "-h" || $# -lt 2 || $# -gt 3 ]]; then
    print_usage
    return
fi

# clear vars
unset SEQ SHOT TYPE ASSET DEPT

# figure out what to do
if [[ $# -eq 1 ]]; then
    # setting a sequence or asset type
    if [[ -d $PROJECT_DIR/seq/$1 ]]; then
        # setting a sequence
        export SEQ=$1
    elif [[ -d $PROJECT_DIR/asset/$1 ]]; then
        # setting an asset type
        export TYPE=$1
    else
        print_usage
    fi
elif [[ $# -eq 2 ]]; then
    # setting a shot or asset
    if [[ -d $PROJECT_DIR/seq/$1/$2 ]]; then
        # setting a shot
        export SEQ=$1
        export SHOT=$2
    elif [[ -d $PROJECT_DIR/asset/$1/$2 ]]; then
        export TYPE=$1
        export ASSET=$2
    else
        print_usage
    fi
elif [[ $# -eq 3 ]]; then
    # setting a shot or asset dept
    if [[ -d $PROJECT_DIR/seq/$1/$2/$3 ]]; then
        # setting a shot dept
        export SEQ=$1
        export SHOT=$2
        export DEPT=$3
    elif [[ -d $PROJECT_DIR/asset/$1/$2/$3 ]]; then
        export TYPE=$1
        export ASSET=$2
        export DEPT=$3
    else
        print_usage
    fi
fi

# re-source the environment
. ${ENV_ETC_DIR}/studio.sh

cd $WORK_DIR
