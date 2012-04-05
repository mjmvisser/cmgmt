
function print_usage ()
{
    echo "Usage: setproject PROJ"
    echo ""
    echo "Valid projects are:"
    local projects=( $PROD_DIR/*/ )
    projects=( ${projects[@]%%/} )
    projects=( ${projects[@]##*/} )
	echo ${projects[@]}
}

function _setproject()
{
    local cur prev cword
    
    COMPREPLY=()

    _get_comp_words_by_ref cur prev cword 
    
    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-? -h' ) )
    elif [[ $cword = 1 ]]; then
        local projects=( $PROD_DIR/$cur*/ )
        _dirnames projects
        
        COMPREPLY=( ${projects[@]} )
    fi
} && complete -F _setproject setproject

#
# main
#

if [ "$!" = "-?" -o "$1" = "-h" -o $# -ne 1 -o ! -d "$PROD_DIR/$1" ]; then
    print_usage
    return
fi

if [[ $PROJECT != $1 ]]; then
	# only change things if a different project is specified

	# set the project variable
	export PROJECT=$1

	# unset state
	unset SEQ SHOT TYPE ASSET DEPT 
	
    # save state
    echo "PROJECT=$PROJECT" > $HOME/.config
    echo "unset SEQ" >> $HOME/.config
    echo "unset SHOT" >> $HOME/.config
    echo "unset TYPE" >> $HOME/.config
    echo "unset ASSET" >> $HOME/.config
    echo "unset DEPT" >> $HOME/.config
fi

	
# re-source the environment, even if nothing changed, to be consistent
. $ENV_ETC_DIR/studio.sh
