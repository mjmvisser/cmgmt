
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

# stash it so it sticks
echo $PROJECT > $HOME/.project


if [[ $PROJECT != $1 ]]; then
	# set the project variable
	export PROJECT=$1

	# unset state
	unset SEQ SHOT TYPE ASSET DEPT 
	
	# re-source the environment
	. $ENV_ETC_DIR/studio.sh
fi