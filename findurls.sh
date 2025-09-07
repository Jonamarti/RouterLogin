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
findUrlsParallel () {
  rm -f ./existingURLs.txt
  for part1 in $(seq $start_part1 $end_part1); do
    for part2 in $(seq $start_part2 $end_part2); do
      for part3 in $(seq $start_part3 $end_part3); do
        for part4 in $(seq $start_part4 $end_part4); do
          tryEndpoint "$part1.$part2.$part3.$part4" &
        done
      done
    done
  done
}

findUrls () {
  for part1 in $(seq $start_part1 $end_part1); do
    for part2 in $(seq $start_part2 $end_part2); do
      for part3 in $(seq $start_part3 $end_part3); do
        for part4 in $(seq $start_part4 $end_part4); do
          tryEndpoint "$part1.$part2.$part3.$part4";
        done
      done
    done
  done
}

# Without -L, curl doesn't follow redirects, so if the request throws a redirection status code thats what it will return. Other libraries, such as PowerShell's Invoke-WebRequest does follow the redirection by default.

tryEndpoint () {
  url="http://$1"
  status_code=$(curl -s -o /dev/null -w "%{http_code}" -L --max-time 0,1 "$url")
  # 000 status code means the request has timed out

  if [ "$status_code" -eq 200 ]; then
    echo "$url" > existingURLs.txt
  fi
  # If we want to check redirections, we could pay attention to 30x status codes without the -L flag (for follow redirections)
  # if [ "$status_code" -eq 307 ]; then
  #   echo "$url" > existingURLs.txt
  # fi
}

findUrlsParallel