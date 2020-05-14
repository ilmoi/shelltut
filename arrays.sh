#!/bin/sh

# basically the assoc array shit seems not to work on sh/bash. uncomment for now.


# arrays


echo ----------- declaring!
# there are 2 types of arrays in bash - indexed and associative
# indexed arrays are indexed using numbers and are thus similar to normal arrays in python
# we can create them using one of 2 ways:

# declare -a my_array2
my_array=(foo bar tar)

# associative arrays are like dictionaries, indexed using strings
# declare -A my_assoc_array #does not work on sh/bash, but works on zsh


echo ----------- setting!
# indexed
my_array[5]="neo star"
my_array+=(add many elems at once)

# associative
# my_assoc_array["key1"]="val1"
# my_assoc_array["key2"]="val2"
# my_assic_array+=(["one"]="onez" [two]=2 [three]=3 [four]=4) #doesn't work and I think that's because of version or particular shell


echo ----------- geting!
echo ${my_array[@]} #on sh just $my_array print only the first elem
echo ${my_array[0]}
# echo $my_array[1] #works on zsh, not sh

# read more -> https://stackoverflow.com/questions/3348443/a-confusion-about-array-versus-array-in-the-context-of-a-bash-comple
echo --- using @ and quotes
for i in "${my_array[@]}"; do #generates 4 variables PROBABLY THE ONE YOU WANT MOST OF THE TIME
    echo $i
done
# echo --- using \* and quotes
# for i in "${my_array[*]}"; do #generates 1 variable composed of 4 IFS separated inputs
#     echo $i
# done
# echo --- using @
# for i in ${my_array[@]}; do #note this behaves very differently on zsh
#     echo $i
# done
# echo --- using \*
# for i in ${my_array[*]}; do #note this behaves very differently on zsh
#     echo $i
# done

# echo --- # associative
# echo $my_assoc_array


# echo ----------- indexing!
# # does not work on zsh
# for index in "${!my_array[@]}"; do
#     echo $index
# done
#
# for key in "${!my_assoc_array[@]}"; do
#     echo "$key"
# done


echo ----------- measuing!
echo "array length is ${#my_array[@]}" #get the length!
# echo "assoc array length is ${#my_assoc_array[@]}" #get the length!


echo ----------- deleting!
echo ${my_array[@]}
# unset "my_array[1]" #works on zsh
unset my_array[1] #works on bash/sh
echo ${my_array[@]}
unset my_array[2] #works on bash/sh
echo ${my_array[@]}
unset my_array[5] #works on bash/sh
echo ${my_array[@]}
# moral of the story - you need to know specific indices you want to remove.
# and eg the above we're using 5 not 3 even though tecthnically the next one is 3.
# that's because earlier we declared my_array[5]="neo star"

# to delete the entire array just pass unset without any argument
unset my_array
echo ${my_array[@]}
