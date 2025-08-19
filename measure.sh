#!/bin/bash
source script.sh
start=$(date +%s%N)
echoWith

end=$(date +%s%N)
echo "Elapsed time with &: $(($(($end-$start))/1000000)) ms"

start=$(date +%s%N)
echoWithout

end=$(date +%s%N)
echo "Elapsed time without &: $(($(($end-$start))/1000000)) ms"
