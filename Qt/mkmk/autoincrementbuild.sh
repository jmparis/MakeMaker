#!/bin/bash
number=`cat build_number | tr -d '\r'`
number=`expr $number + 1`
echo "$number" | tee build_number
#<-- output and save the number back to file
