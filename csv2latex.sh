#!/bin/bash

HEADERLINE=''
INPUT=''
OUTPUT=''

function printHelp {
    echo "Usage: csv2latex [OPTIONS] -i <input file> -o <output file>"
    echo "Converts a csv file into a latex table."
    echo "Flags:"
    echo "  -h  Include a header line"
    echo ""
}

# Read flags
while getopts 'hi:o:' flag; do
    case "${flag}" in
        h)  HEADERLINE='true' ;;
        i)  INPUT="${OPTARG}" ;;
        o)  OUTPUT="${OPTARG}" ;;
        *)  printHelp
            exit 1 ;;
    esac
done

# check if input and outfile files were given
if [ -z $INPUT ]; then
    echo "No input file given. Use -i <input file>."
    exit 1
elif [ -z $OUTPUT ]; then
    echo "No output file given. Use -o <output file>."
    exit 1
fi

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
    if [[ $CURRENTLINE -eq 1 && $HEADERLINE ]]; then
        # Add header line
        echo ' \\ \hline \hline' >> $OUTPUT
    elif [ $CURRENTLINE -lt $NUMLINES ]; then
        # Omit line break on final line
        echo ' \\ \hline' >> $OUTPUT
    else
        echo "" >> $OUTPUT
    fi

done

# Print ending enviornment
echo '\end{tabular}' >> $OUTPUT;
