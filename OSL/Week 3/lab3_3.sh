#!/bin/bash

for file in $(find . -name "*.txt")
do
    dir=$(dirname "$file")
    base=$(basename "$file" .txt)
    
    mv "$file" "$dir/$base.text"
done

# 3. Write a shell script to replace all files with .txt extension with .text in the current directory. This has to be done recursively i.e if the current folder contains a folder “OS” with abc.txt then it has to be changed to abc.text ( Hint: use find, mv )
