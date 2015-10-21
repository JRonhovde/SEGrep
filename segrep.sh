# V1.0 2015-10-21
segrep(){
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    FILES=$(cat "$DIR/segrep.txt")
    COMMAND="eval find $FILES 2>&-"
    OPTIONS=""
    for var in "$@"
    do
        if [[ "$var" =~ -[A-Za-z]$ ]]; then
            OPTIONS="$OPTIONS $var"
            shift
        fi
    done

    if [ "$2" == "open" ]; then
        # opens all matching files in vim
        vim $(echo $($COMMAND)  | xargs grep -l --color=never "$1")
    elif [ "$2" == "files" ]; then
        # lists all files containing matching string
        echo $($COMMAND) | xargs grep -l $OPTIONS "$1"
    elif [ "$2" == "count" ]; then
        # lists all matching files with # of occurences per file, skipping files with 0 matches
        echo $($COMMAND) | xargs grep -c $OPTIONS "$1" | sed '/[^1-9]0[^0-9]\?/d'
    elif [ "$2" == "total" ]; then
        # counts total number of occurences in all files
        echo $($COMMAND) | xargs cat | grep -c $OPTIONS "$1"
    elif [ "$2" == "viewfiles" ]; then
        # opens list of matching files in vim using stdin 
        echo $($COMMAND) | xargs grep -l --color=never $OPTIONS "$1" | vim -
    elif [ "$2" == "viewcountfiles" ]; then
        # opens list of matching files with # of matches per file in vim using stdin 
        echo $($COMMAND) | xargs grep -c --color=never $OPTIONS "$1" | sed '/:0$/d' | vim -
    elif [ "$2" == "notfiles" ]; then
        # reverse grep for filenames
        echo $($COMMAND) | xargs grep -L $OPTIONS "$1"
    elif [ "$2" == "notcount" ]; then
        # reverse grep for filenames - total number of files
        echo $($COMMAND) | xargs grep -L $OPTIONS "$1" | wc -l
    else
        # regular grep
        echo $($COMMAND) | xargs grep $OPTIONS "$1"
    fi
    return 0
}
