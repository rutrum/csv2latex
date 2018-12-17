#!/bin/bash

# EXPECTED PARAMETERS
#   $1: input file
#   $2: output file

# For now, we expect no headers

INPUT=$1
OUTPUT=$2

# Print starting enviornment
echo -n '\begin{tabular}{' > $OUTPUT;

# Determine width by examining first line
FIRST=$( head -n 1 $INPUT | sed s/,/" "/g )
for i in $FIRST
do
    echo -n "l" >> $OUTPUT
done

# Finish starting enviornment
echo "}" >> $OUTPUT

# We add another counter for special formatting on last line
NUMLINES=$(wc -l < $INPUT)
CURRENTLINE=0

cat $INPUT | while read LINE; do
    let CURRENTLINE++

    # First we change commas to spaces
    # and treat LIST as an array
    LIST=($( echo $LINE | sed s/,/" "/g ))
    TOTAL=${#LIST[@]}

    # Tab
    echo -n "    " >> $OUTPUT

    # Print first element
    echo -n ${LIST[0]} >> $OUTPUT
    unset LIST[0]

    # Print remaining elements
    for i in "${LIST[@]}"; do
        echo -n " & " >> $OUTPUT
        echo -n $i >> $OUTPUT
    done
    
    # Print end line
    if [ $CURRENTLINE -lt $NUMLINES ]; then
        echo ' \\ \hline' >> $OUTPUT
    else
        echo "" >> $OUTPUT
    fi

done

# Print ending enviornment
echo '\end{tabular}' >> $OUTPUT;
