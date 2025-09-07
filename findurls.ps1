# Extract the parts of the IP address range
$start_part1 = 192
$start_part2 = 168
$start_part3 = 0
$start_part4 = 0

$end_part1 = 192
$end_part2 = 168
$end_part3 = 1
$end_part4 = 1

# Generate the list of IP addresses
function Find-UrlsParallel {
    Remove-Item -Path ./existingURLs.txt -ErrorAction SilentlyContinue
    for ($part1 = $start_part1; $part1 -le $end_part1; $part1++) {
        for ($part2 = $start_part2; $part2 -le $end_part2; $part2++) {
            for ($part3 = $start_part3; $part3 -le $end_part3; $part3++) {
                for ($part4 = $start_part4; $part4 -le $end_part4; $part4++) {
                    Find-Endpoint -Url "http://$part1.$part2.$part3.$part4"
                }
            }
        }
    }
}

function FindUrls {
    Remove-Item -Path ./existingURLs.txt -ErrorAction SilentlyContinue
    for ($part1 = $start_part1; $part1 -le $end_part1; $part1++) {
        for ($part2 = $start_part2; $part2 -le $end_part2; $part2++) {
            for ($part3 = $start_part3; $part3 -le $end_part3; $part3++) {
                for ($part4 = $start_part4; $part4 -le $end_part4; $part4++) {
                    Find-Endpoint -Url "http://$part1.$part2.$part3.$part4"
                }
            }
        }
    }
}

function Find-Endpoint ($Url) {
    try {
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -ErrorAction SilentlyContinue -TimeoutSec 1
        if ($response.StatusCode -eq 200) {
            Add-Content -Path ./existingURLs.txt -Value $Url
        }
    }
    catch {
        # Ignore errors
    }
}

# Find-UrlsParallel