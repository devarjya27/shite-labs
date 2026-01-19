#!/bin/bash

touch temp.txt
count=1

while read -r line
do
    if [ $((count % 2)) -ne 0 ]; then
        echo "$line" >> temp.txt
    fi
    count=$((count + 1))
done < $1

mv temp.txt "$1"
