# find valid URLs and then perform POST requests trying the most common credentials
source findurls.sh
source trycredentials.sh

findUrlsParallel 
trycredentials "credentials.txt" "existingURLs.txt"

