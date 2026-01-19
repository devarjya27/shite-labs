#!/bin/bash

if [ -d "$1" ]; then
echo "'$1' is a directory."
elif [ -f "$1" ]; then
echo "'$1' is a file."
else
echo "'$1' is neither a file nor a directory."
fi

# 1. Write a shell script to find whether a given file is the directory or regular file.
