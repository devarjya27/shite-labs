#!/bin/bash

read basic
read ta

# 10 percent of basic
rate=$(echo "$basic * 0.10" | bc)

# total salary
gs=$(echo "$basic + $ta + $rate" | bc)

echo $gs

# 4. Write a shell script to calculate the gross salary. GS=Basics + TA + 10% of Basics. Floating point calculations has to be performed.
