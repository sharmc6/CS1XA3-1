#!/bin/bash

#informs you if the local repo is up to date with the remote repo
function isUpToDate () {
    $(git fetch origin)
    localRepo=(git rev-parse master)
    remoteRepo=(git rev-parse origin/master)
    if [ $localRepo == $remoteRepo ]
    then
        echo "Local Repo is up to date with Remote Repo"
    else
        echo "Local Repo is not up to date with Remote Repo"
    fi
}

function uncommittedChanges () {
    git diff > changes.log
}

function findTODO () {
    grep -r -e "#TODO" --exclude="todo.log" --exclude="ProjectAnalyze.sh" > todo.log 
}

#checks all haskell files for syntax errors and puts the results into error.log
function haskellErrors () {
    find -name "*.hs" | xargs -I {} ghc -fno-code {} &> error.log   
}

#moves up n number of directories
function moveUp () {
    read -p "Would you like to move up directories? (Y/N)" ans
    if [ $ans == "Y" ]
    then 
        read -p "How many directories would you like to move up?" num
        i=0
        d=$PWD
        while [ $i -le $num ]
        do
	    d=$d/..
            ((i++))
        done
    fi
}

"$@"
