# find valid URLs and then perform POST requests trying the most common credentials
# source the scripts
. ./findurls.ps1
. ./testcredentials.ps1

Find-UrlsParallel 
Test-Credentials -CredentialsFile "credentials.txt" -URLsFile "existingURLs.txt"

