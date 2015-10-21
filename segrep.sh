# better grep
# syntax: gr string method
# example: gr "functionName" open
# result: opens all files containing functionName in vim buffers
segrep(){
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    FILES=$(cat "$DIR/segrep.txt")
    COMMAND="eval find $FILES 2>&-"
    if [ "$2" == "open" ]; then
        # opens all matching files in vim
        vim $(echo $($COMMAND)  | xargs grep -l --color=never $1)
    elif [ "$2" == "files" ]; then
        # lists all files containing matching string
        echo $($COMMAND) | xargs grep -l $1
    elif [ "$2" == "count" ]; then
        # lists all matching files with # of occurences per file, skipping files with 0 matches
        echo $($COMMAND) | xargs grep -c $1 | sed '/:0$/d'
    elif [ "$2" == "total" ]; then
        # counts total number of occurences in all files
        echo $($COMMAND) | xargs cat | grep -c $1
    elif [ "$2" == "viewfiles" ]; then
        # writes matching file names into a file (greptest.txt) then opens greptest.txt 
        echo $($COMMAND) | xargs grep -l --color=never $1 | vim -
    elif [ "$2" == "viewcountfiles" ]; then
        # writes matching file names into a file (greptest.txt) with # of matches then opens greptest.txt  
        echo $($COMMAND) | xargs grep -c --color=never $1 | sed '/:0$/d' | vim -
    elif [ "$2" == "notfiles" ]; then
        # reverse grep for filenames
        echo $($COMMAND) | xargs grep -L $1
    elif [ "$2" == "notcount" ]; then
        # reverse grep for filenames
        echo $($COMMAND) | xargs grep -L $1 | wc -l
    else
        # regular grep
        echo $($COMMAND) | xargs grep $1
    fi
    return 0
}
