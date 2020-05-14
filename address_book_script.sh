#!/bin/sh


# ==============================================================================
# HELPER FUNCS


printdb(){
    awk -F":" '
    BEGIN {
    print "===================================================================="
    printf "%-4s %20s %20s %20s\n", "ID", "NAME", "PHONE", "EMAIL"
    print "===================================================================="
    }
    NR>=2 {
    printf "%-4s %20s %20s %20s\n", $1, $2, $3, $4 } ' database.txt
}


get_input(){
    ALL_IDS=`cut -d ":" -f 1 database.txt`
    read -p "choose an ID: " ID
    if [[ $ALL_IDS =~ $ID ]]; then #if ID in ALL_IDS
        # LINE=$((ID + 1)) #old. breaks down when IDs no longer follow certain order
        LINE=`grep -in "^${ID}" database.txt | cut -d ":" -f 1`
        return
    else
        echo "oops lets try again"
        get_input
    fi
}


# ==============================================================================
# MAIN FUNCS


search(){
    read -p "Please enter name or surname: " INPUT
    echo "you typed in ${INPUT}. Looking up in the database..."

    # first check if input has something, otherwise just print the entire db
    if [ $INPUT ]; then
        FOUND=`grep -i $INPUT database.txt`

        # second check if we actually found the right contact
        if [ "$FOUND" ]; then
            echo hooray
            for line in $FOUND; do
                printf "${line}\n"
            done
            # awk -F":" ' { printf "%-20s %20s %20s\n", $1, $2, $3 } ' database.txt
        else
            echo "Hmm cant find anything. Try again?"
            search
        fi

    else
        echo "sounds like you just want to see the entire db"
        printdb
    fi
}


edit(){
    get_input
    read -p "choose an attribute to edit: 1)name, 2)phone, 3)email: " ATTR
    read -p "enter the new value: " WORD

    case $ATTR in
                      # NOTE: -i flag (edit in place) works differently on mac vs linux (https://stackoverflow.com/questions/5694228/sed-in-place-flag-that-works-both-on-mac-bsd-and-linux)
                      # NOTE: -e flag simply means script to be executed
                      # NOTE: need to use double quotes not single quotes around the expression
                      # NOTE: got the idea for sed from here https://stackoverflow.com/questions/3275274/how-to-replace-3rd-word-in-a-line-using-sed and here https://stackoverflow.com/questions/11145270/how-to-replace-an-entire-line-in-a-text-file-by-line-number
                      # NOTE: indexing for words starts from 1 not 0, so have to add 1
        name|1)       sed -i '' -e "${LINE}s/[^:]*[^:]/${WORD}/2" database.txt;;
        phone|2)      sed -i '' -e "${LINE}s/[^:]*[^:]/${WORD}/3" database.txt;;
        email|3)      sed -i '' -e "${LINE}s/[^:]*[^:]/${WORD}/4" database.txt;;
        *)            echo try again;;
    esac

    echo "-------- DONE! --------"
    printdb
}


remove(){
    get_input #this sets the global ID & LINE variables
    # very cool. the below command composed of 3 things: cat the file > pick 2nd word (name) > pick selected line
    NAME=`cat database.txt | cut -d ":" -f 2 | sed -n ${LINE}p`
    echo "are you sure you want to delete ${NAME}'s record'?"
    read -p "[type yes]" CONFIRM
    if [ $CONFIRM = "yes" ]; then

        sed -i '' -e "${LINE}d" database.txt

        echo "-------- DONE! --------"
        printdb
    else
        echo no
    fi
}


add(){
    read -p "what's their name? " NAME
    read -p "what's theit phone number? " PHONE
    read -p "what's their email address? " EMAIL

    echo "are you sure you want to add the below record?"
    echo "NEW RECORD: ${NAME}:${PHONE}:${EMAIL}"
    read -p "[type yes]" CONFIRM
    if [ $CONFIRM = "yes" ]; then
        # get all ides
        ALL_IDS=`cut -d ":" -f 1 database.txt`''

        # turn them into array
        SAVEIFS=$IFS
        IFS=$'\n'
        ALL_IDS_ARR=(`echo ${ALL_IDS}`)
        IFS=$SAVEIFS

        # remove first (id) element
        delete=(id) #dunno why unset didn't work
        ALL_IDS_ARR=( "${ALL_IDS_ARR[@]/$delete}" )

        # find max
        max=0
        for i in ${ALL_IDS_ARR[@]}; do
            if (( $i > $max )); then max=$i; fi;
        done

        # set new index
        ADD_ID=$(( max + 1 ))

        echo "${ADD_ID}:${NAME}:${PHONE}:${EMAIL}" >> database.txt
        echo "Contact added under new ID: ${ADD_ID}."
    fi

    echo "-------- DONE! --------"
    printdb
}


# ==============================================================================
# TIME TO PLAY!


# start by resetting the database
cat db_backup.txt > database.txt


play(){
    read -p 'what would you like to do? 1=search, 2=add, 3=remove, 4=edit: ' ACTION
    case $ACTION in
        search|1)   search;;
        add|2)      add;;
        remove|3)   remove;;
        edit|4)     edit;;
        *)          echo "unrecognized input, try again?";;
    esac
    play
}
play
