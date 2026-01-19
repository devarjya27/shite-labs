#!/bin/bash

for file in $(find . -name "*.txt")
do
    dir=$(dirname "$file")
    base=$(basename "$file" .txt)
    
    mv "$file" "$dir/$base.text"
done
