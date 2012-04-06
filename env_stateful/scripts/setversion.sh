
function print_usage ()
{
    echo "Usage: setversion APP VERSION"
    echo ""
    echo "Valid apps are:"
    local apps=( $ENV_ETC_DIR/apps.d/*.sh )
    apps=( ${apps[@]##*/} )
    apps=( ${apps[@]%%.*} )
	echo ${apps[@]}
}

function _setversion()
{
    local cur prev cword
    
    COMPREPLY=()

    _get_comp_words_by_ref cur prev cword 
    
    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-? -h' ) )
    elif [[ $cword = 1 ]]; then
        COMPREPLY=( $( ls -1 $ENV_ETC_DIR/apps.d/ | egrep -o "^${cur}[^.]+" | sort ) )
    else
        local uc_app app_location app_version
        
        uc_app=$(echo $prev | tr '[:lower:]' '[:upper:]')
    
        eval "app_location=${uc_app}_LOCATION"
        eval "app_version=${uc_app}_VERSION"

        COMPREPLY=( $( ls -1d ${!app_location/${!app_version}/${cur}*} | egrep -o '[0-9]*[0-9v.]*[0-9]+' ) )
    fi
} && complete -F _setversion setversion


#
# main
#

if [ "$!" = "-?" -o "$1" = "-h" -o $# -ne 2 -o ! -r "${ENV_ETC_DIR}/apps/$1.sh" ]; then
    print_usage
    return
fi

# generate an upper-case app name
uc_app=$(echo $1 | tr '[:lower:]' '[:upper:]')

# set the version variable
eval "export ${app}_VERSION=$2"

# re-source the environment
. ${ENV_ETC_DIR}/studio.sh
