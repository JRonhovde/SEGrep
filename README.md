# segrep
V1.0.1 2015-10-29

### Setup    
1. Clone this repository: `git clone https://github.com/JRonhovde/segrep.git`    
2. Create a file named `segrep.txt` with the directory paths and file names/extensions 
you wish to search(see segrep.example.txt).
3. Source segrep.sh in your .bashrc or .bash_profile, e.g. `source ~/segrep/segrep.sh`.    

### Commands    
`segrep pattern` - normal grep output    

`segrep pattern files` - list of files containing pattern     

`segrep pattern count` - same as `files`, but includes # of matches per file     

`segrep pattern total` - total # of matches     

`segrep pattern notfiles` - list of files not containing pattern     

`segrep pattern notcount` - # of files that do not contain pattern     

`segrep pattern open` - open all files containing pattern in vim buffers     

`segrep pattern viewfiles` - open list of matching files in vim    

`segrep pattern viewcountfiles` - same as `viewfiles` but includes matches per file    

You can also pass regular grep options as part of the command, e.g. `segrep -iv pattern` will match lines that do not contain pattern and ignore case. Some grep options might conflict with the more complex commands, use at your own risk.
