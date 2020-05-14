 #!/bin/sh

"""Tutorial taken from https://www.shellscript.sh/"""

# this is a fucking comment

echo ---------------------------------------- 4 variables

# variables - we can set them like this. Must assign signle thing on RHS per single variable
MY_MESSAGE='Hello Worldz'
MY_NUM=1
echo $MY_MESSAGE
echo $MY_NUM

# we can interactively set variables using the read command
# echo what is your name sir? # note we can pass without quotes coz it accepts more than one arg and prints them all
# read MY_NAME # note automatically puts "" around the input
# echo "hellozza $MY_NAME"

# shell doesnt give you an error for vars that dont exist
echo $VAR_THAT_IS_NOT_DEFINED

# scope of variables
# when you run a shell script, because of the shebang on the first line you're effectively spawning a new shell
# this means any variables defined in existing shell are NOT passed to your script
# NOTE: in order to pass the variables to your script you should use export in the shell
echo $TEST_VAR
TEST_VAR='now its set'
echo $TEST_VAR
# if you write TEST_VAR=whatever before running above, there won't be an effect
# but if you write export TEST_VAR=whatever, you'll see an effect
# similarly, the script does not automatically pass variables to the shell
# NOTE: in order to retrieve a variable from the script you need to source it: . ./my-script.sh

# re-using variables
# echo what is your name mate
# read USER_NAME
# echo "hello $USER_NAME"
# echo "let me create a variable for you"
# touch "${USER_NAME}_file" #note how $ needs to go BEFORE the curly braces

echo ---------------------------------------- 6 escape chars

# some characters are considered special in the shell. They are interpreted even if they're passed in a string
# they are: 1)" 2)$ 3)` 4)\
echo `ls` # here `backticks` indicate a command to be run

echo ---------------------------------------- 7 loops

# # loops!
for i in 1 2 3 4 5
do
    echo "crazy but it's a shell loop! NR: $i"
done
#
# for i in hello 1 * 2 goodbye #very coool - * goes through the entire directory
# # for i in hello 1 *.txt 2 goodbye #this only loops through txt files
# # for i in hello 1 *.json goodbye #this onle loops through json files
# do
#     echo "looping ... i is set to $i"
# done
#
# INPUT_STRING=hello
# while [ "$INPUT_STRING" != bye ]
# do
#     echo "please type something in (bye to quit)"
#     read INPUT_STRING
#     echo "You typed: $INPUT_STRING (type bye to quit dumbass)"
# done
#
# while : #colon always evaluates to true
# do
#     echo "Please type something in (^C to quit)"
#     read INPUT_STRING
#     echo "whatever you type wont help. ctrl c it mate"

# here's how you would read a file and check its contents
# while read f #here we do a while loop
# do
#     case $f in # here we tell it what processing to do
#         hello)      echo English ;;
#         howdy)      echo American ;;
#         gday)       echo Australian ;;
#     esac
# done < myfile # this is where we tell the system what file it's looking at

# while read line
# do
#     echo $line $line $line
# done < myfile

echo ---------------------------------------- 8 test

# to do if statements we use the "test" module, also known as "[]".
# note it's important to place spaces correctly around, like this:
# if SPACE [ SPACE "$foo" SPACE = SPACE "bar" SPACE ]
# also note that this is why you should NOTE: never call your files "test" coz they will be invoked instead of this module
foo=tar
if [ $foo = bar ]; then
    echo hoooray
elif [ $foo = tar ]; then
    echo almost
else
    echo wtf
fi

if [ "$X" -lt "0" ]; then
    echo "X is less than zero"
fi

if [ "$X" -gt "0" ]; then
    echo "X is greater than zero"
fi

[ "$X" -le "0" ] && \
#&& is used to chain commands together - next one only run if preceding executed correctly - what he's doing here is chaining all the if statements that follow
# \ is used the same way as in python - signals continuation of the line on next line
# thus backslash \ and semicolon ; serve the opposite purposes
    echo "X is less than or equal to zero"
[ "$X" -ge "0" ] && \
    echo "x is greater than or equal to zero"
[ "$X" = "0" ] && \
    echo "X is the string or number 0"
[ "$X" = "hello" ] && \
#interesting both = and == work here
    echo "X matches the string \"hello\""
[ "$X" != "hello" ] && \
    echo "X does not match the string \"hello\""
[ -n "$X" ] && \
    echo "X is of non zero length"
[ -f "$X" ] && \
    echo "X is a path to a REAL file" || echo "no such file exists"
[ -x "$X" ] && \
    echo "X is the path to an executable"
[ "$X" -nt "/etc/passwd" ] && \
 echo "X is a file which is newer than /etc/passwd"

# thus from the above we can see a simpler way of chaining together commands
# first command && second && third || if not then this one
 [ $X -ne 0 ] && echo "X isn't zero" || echo "X is zero"

 # note that -lt -gt -le -ge expect and integer and will complain if it's not one

 # here's a simple script that keeps asking for user's input until they enter nothing and just hit return
#  X = 0
#  while [ -n "$X" ]
#  do
#      echo enter something or hit RETURN to quit
#      read X
#      echo fuck you
# done

echo ---------------------------------------- 9 case

echo "Please talk to me ..."
while : #again, semicolon = true
do
    read INPUT_STRING
    case $INPUT_STRING in #this looks weird but is just how the cases work
        hello)      echo "hello yourself motherfucker";; #double semicolon indicates end of case statement
        bye)        echo "see you again motherfucker"; break ;;
        *)          echo "me not understand";; #default catch all condition
    esac
done
echo "thats it folks"

echo ---------------------------------------- 10 variables pt2

# there exist some special variables that are predefined for us and that we can't change
echo "i was called with $# params"
echo "my name is $0"
echo "my first param is $1"
echo "my second param is $2"
for i in 1 2 3 4 5
do
    echo "argument $i is {\$$i}" #cant get this to work... unfortunately
done
echo "all params are $@"

# we can echo more than 9 arguments by using the shift command
while [ "$#" -gt 0 ] #while number of params is greater than 0
do
    echo "\$1 is $1"
    shift # keeps shifting until args are 0
done

# another special command is $? which records the exit value of the last run command
# /usr/local/bin/python3
# # if it executes successfully then the value becomes 0, otherwise != 0 and the below is run
# if [ "$?" -ne "0" ]; then
#     echo "sorry, we had a problem there!"
# fi

# more variables:
# $$ = PID (process identifier) of the currently running shell
# $! = PID (process identifier) of the last run background process

# to sum:
# $0 = current command, $1-9 = arguments
# $# = number of args, $@ = all args
# $? = exit value (0 or not)
# $$ / $! = PIDs

echo ---------------------------------------- 11 variables pt3

foo=bar
echo $foobells #does not work (no error though - and moreso, it doesnt quit the execution unlike python)
echo ${foo}bells #works ok as expected

# take this script
# echo "waht is your name [ `whoami` ]"
# read myname
# if [ -z "$myname" ]; then #I think this is saying if the input is empty
#     myname=`whoami`
# fi
# echo "your name is : $myname"

# it can be written better using curly brackets
# echo "what is your name [ `whoami` ]"
# read myname
# echo "your name is : ${myname:-`whoami`}" #the :- syntax is used to indicate the default value
# echo "your name is : ${myname:-zopa}" #eg here it'd be a fixed variable rather than from user's input

echo ---------------------------------------- 12 external programs

# MY_NAME=`ls -la` # text inside of backticks gets executed as a command and replaced with the output
# echo $MY_NAME

HTML_FILES=`find ~/Dropbox/shelltut *.html`
echo ">>>running first search"
echo "$HTML_FILES" | grep rando # note that quotes around HTML_FILES are essential to preserve the newlines between each file listed
echo ">>>running second search"
echo "$HTML_FILES" | grep 1

echo ---------------------------------------- 13 functions

# you can write the functions in the same file or you can take them out to a different one.
# in the latter case you need to source it like this: . ./library.sh
# we can call them "functions" or "procedures" - but "functions" is more common

# a function can return its value in one of 4 ways:
# 1 - change the state of some var
# 2 - use the exit command to end the shell script
# 3 - use the return command to end the function call and return a value
# 4 - echo output to stdout which will be caught by the caller this is a test of t

# here a  simple function example
# note that the code will not be executed until its called (only read and checked for syntax)
add_a_user()
{
    USER=$1
    PASSWORD=$2
    shift; shift;
    COMMENTS=$@
    echo "added user $USER ($COMMENTS) with pass $PASSWORD"
}

add_a_user ilja shittypass me be big dog

# function in shell share scope with global env

X=1
echo $X

shitty_scope()
{
    echo running a fucking function!
    echo watch out for that scope
    X=2
    echo $1 $2 $@
}

# shitty_scope raz dva tri
# echo $X #becomes 2

# except for $1, $2, $@, etc
echo $1 $2 $@ #prints nothing

# this wouldn't be the case if the function was piped somewhere eg
# that's because during piping a new shell is spawned to run the function before it's released into the current shell. thus X=2 happens in that new, temporary shell
shitty_scope | xargs echo
echo $X #stays as 1

a="original value"
echo $a

myfunc()
{
    # functions cant change the passed variables $0, $1, $2, etc
    # eg
    1=potato #this is not valid syntax and will produce an error
    echo $1
    # however they can change any other global vars, like we've seen before
    a="has been changed!"
    echo $a
}

myfunc ilja

factorial()
{
    if [ "$1" -gt "1" ]; then
        i=`expr $1 - 1`
        j=`factorial $i`
        k=`expr $1 \* $j`
        echo $k
    else
        echo $1
    fi
}

factorial 5

# . ./common.lib #I noticed I can name this thing both .lib and .sh, but I'm guessing .lib is the right way to do it
# echo $STD_MSG
# echo *.txt
# rename .txt .bak

# finally lets play a bit with return codes

# echo ---------------------
#
# adduser()
# {
#     USER=$1
#     PASSWORD=$2
#     shift; shift
#     COMMENTS=$@
#     useradd -c "${COMMENTS}" $USER #wont work on mac since it's a linux command, but you ge the idea
#     if [ "$?" -ne "0" ]; then
#         echo "useradd failed"
#         return 1
#     fi
#     passwd $USER $PASSWORD
#     if [ "$?" -ne "0" ]; then
#         echo "setting password failed"
#         return 2
#     fi
#     echo "added user $USER ($COMMENTS) with pass $PASSWORD"
# }
#
# adduser bob letmein Bob Holness from Blockbusters
# ADDUSER_RETURN_CODE="$?"
# echo $ADDUSER_RETURN_CODE
# if [ $ADDUSER_RETURN_CODE -eq "1" ]; then
#     echo "something went wrong with adding user"
# elif [ $ADDUSER_RETURN_CODE -eq "2" ]; then
#     echo "something went wrong with setting password"
# else
#     echo "bob holness added to the system"
# fi

echo ---------------------------------------- derek banas tut
# https://www.youtube.com/watch?v=hwrnmQumtPw

# declare a constant
declare -r NUM1=5

num2=10

# 3 ways to perform arithmetic
num3=$((NUM1+num2)) #ok so this seems to only work in bash, but is a pretty straightforward way to do it
# we need double quotes as otherwise declared variables are treated as strings not as numbers
num4=$`NUM1-num2`
rand=5; let rand+=4

echo $num3
echo $num4
echo $rand

# incrementing and decrementing values
echo "rand++ is printing first then incrementing: $((rand++))"
echo "++rand is incrementing first and then printing $((++rand))"
echo "same with minuses, rand--: $((rand--))"
echo "--rand: $((--rand))"

# using python inside the shell
num7=1.2
num8=3.14
num9=$(python -c "print $num7+$num8")
echo $num9

# we can put in a multi line comment that will cat to the terminal
cat<< END
This text
prints on
many lines
END

# ok so turns out that local scope does exist, you just need to explicitly define it
name="dave"
demLocal(){
    echo "calling local!"
    local name="paul"
    return
}

demLocal

echo $name

# lets now define a function we can actually use
getSum(){
    first_input=$1 #the reason we have to do this is because we can't pass just "1" into sum function below
    second_input=$2
    sum=$((first_input+second_input))
    echo $sum
}

num1=5
num2=6

echo $(getSum num1 num2) #note how we're calling the function - no brackets, just spaces

# we can collect input while asking something on the screen using the -p flag
# read -p "enter a number!" num

# we can use arithmetic inside of conditionals too
if (( ((num % 2)) == 0)); then
    echo hooorayza
fi

# we can form complex conditionals using AND and NOT
if (( ((num > 1)) && ((num < 11)) && ! (( ((num % 2)) == 0 )) )); then
    echo "your number is above 1, below 10, and not even"
fi

str1="not null!"
# checking if a string is null is very similar to python
if [ "$str2" ]; then
    echo "it exists!"
else
    echo "it does not!"
fi

# working with files
file1="./1.bak"
file2="./2.bak"

# check if exists
if [ -e "$file1" ]; then
    echo "$file1 indeed exists!"
fi
# following the same logic we could check:
# -f = is a file
# -d = is a dir
# -w = is writable
# -r = is readable
# -x = is executable
# -G = owned by the group
# -U = owned by the owner
# -O = owned by the user

# we can use regular expressions
# read -p "validate a date: " date

# ^=start, $=end, [0-9]=contains numbers between 0 and 9, {8}=there are at least 8 of them
pat="^[0-9]{8}$"

if [[ $date =~ $pat ]]; then
    echo "$date is valid indeed!"
else
    echo "$date is not valid mate!"
fi

# we can accept 2 numbers at the same time
# read -p "enter 2 numbers to sum: " num1 num2
# echo $((num1+num2))

# now lets say we wanted them to enter 2 numbers, but we think they might use a comma to sep them not a space
# this requires us to change the IFS
# OIFS="$IFS" #save the original one just in case
# IFS=","
# read -p "enter 2 numbers ot sum: " num1 num2
# num1=${num1//[[:blank:]]/} #this will ignore all the spaces
# num2=${num2//[[:blank:]]/}
# echo $((num1+num2))

# IFS="$OIFS" #change back to old ifs to not mess up anything inside of our script

# we can easily replace values inside of a string
samp_string="the dog climbed the potato"
echo "${samp_string//potato/tree}"

# namez=ilja
# here we can insert a default value into the variable if it doesn't already exist (not sure what's the difference bwtween :- and :=, both seem to work)
echo "I am ${namez:=Derek}"

can_vote="to be set"
# we can combine arithmetic with conditions (see earlier for how to do cases)
age=17
((age >= 18?(can_vote=1):(can_vote=0)))
echo $can_vote

# working with stings
some_string="a randomzzA stringzz!"
echo "string length is ${#some_string}" #get the length!
echo "${some_string:2:7}" #slice it up!
echo "${some_string#*A}" #get everything after a certain character!

# using continue and break inside of the loop
num=1 # what we're iterating
while [ $num -le 20 ]; do
    if (( ((num % 2)) == 0 )); then
        echo "oh no it divides by two!"
        num=$((num + 1)) #increment 1
        continue #this jumps back to beginngin of the loop
    fi

    if ((num >= 15)); then
        break #this closes out the loop, as expected
    fi

    echo $num
    num=$((num + 1))
done

# the opposite of while loop is the until loop
num=1
until [ $num == 10 ]; do
    echo "oh no! ${num}'s' still too small!"
    num=$((num + 1))
done

# we can use loops to read inside of files
while read line; do
    printf "Line is: ${line}\n"
done < database.txt
# NOTE: note how we're piping the file into the loop at the end! don't forget it!

# for loops are the same as in C / javascript
for (( i=0; i<=10; i++ )); do
    echo $i
done

# they can also be done using ranges
for i in {A..Z}; do
    echo $i
done

# arrays - see arrays.sh
