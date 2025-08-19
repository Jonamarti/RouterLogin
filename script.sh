#!/bin/bash

# Extract the parts of the IP address range
start_part1=192
start_part2=168
start_part3=0
start_part4=0

end_part1=192
end_part2=168
end_part3=9
end_part4=9

# With the & operator, tasks are put in the background and executed asynchronously, but the system has to manage all those extra processes. 
# For small tasks like an echo its not worth it (only echoing takes from 3 seconds to 71 seconds). For bigger or blocking tasks it gets worthwhile

# Generate the list of IP addresses
echoWith () {
  for part1 in $(seq $start_part1 $end_part1); do
    for part2 in $(seq $start_part2 $end_part2); do
      for part3 in $(seq $start_part3 $end_part3); do
        for part4 in $(seq $start_part4 $end_part4); do
          # echo "$part1.$part2.$part3.$part4" &
          # echo "$part1.$part2.$part3.$part4";
          callEndpoint "$part1.$part2.$part3.$part4" &
          
        done
      done
    done
  done
}

echoWithout () {
  for part1 in $(seq $start_part1 $end_part1); do
    for part2 in $(seq $start_part2 $end_part2); do
      for part3 in $(seq $start_part3 $end_part3); do
        for part4 in $(seq $start_part4 $end_part4); do
          # echo "$part1.$part2.$part3.$part4";
          callEndpoint "$part1.$part2.$part3.$part4";
        done
      done
    done
  done
}

callEndpoint () {
  url="http://$1"
  # echo $url
  status_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 0,1 "$url")
  # echo $status_code
  if [ "$status_code" != 000 ]; then
    if [ "$status_code" -eq 200 ]; then
      echo "URL $url exists (status code $status_code)"
    elif [ "$status_code" -eq 307 ]; then
      echo "URL $url exists (status code $status_code)"
    fi
  fi
}
