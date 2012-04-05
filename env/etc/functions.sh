function _dirnames()
{
    # $1 is the name of the output array 
    
    # make a local copy of the array.. bash, you so awkward
    eval "local result=( \${$1[@]} )"

    # check for no match
    if [[ ${#result[@]} -eq 1 && ${result[0]} =~ \*/$ ]]; then
        result=( )
    else 
	    # strip the trailing /
	    result=( ${result[@]%%/} )
	    
	    # strip the leading directories
	    result=( ${result[@]##*/} )
	    
	    # filter out luts (add other subdirs here as necessary)
	    result=( $( for i in ${result[@]}; do echo $i; done | egrep -i 'luts' ) )
	fi
	
    # assign the result back to the input array
    eval "$1=( ${result[@]} )"
}
