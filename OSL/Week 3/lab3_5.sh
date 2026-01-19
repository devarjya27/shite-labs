#!/bin/bash

mkdir -p "$2"

for file in *$1
do
cp "$file" "$2"
done

