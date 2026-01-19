#!/bin/bash

read basic
read ta

# 10 percent of basic
rate=$(echo "$basic * 0.10" | bc)

# total salary
gs=$(echo "$basic + $ta + $rate" | bc)

echo $gs

