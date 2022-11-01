# regular:
$timeStart = Get-Date
151..160 | ForEach-Object {
    $title = "Test-Parallel-{0:000}" -f $_
    $alias = "Test-Parallel-{0:000}" -f $_
    $owner = "vladilen@uhgdev.onmicrosoft.com"
    New-PnPSite -Type TeamSite -Title $title -Alias $alias -TimeZone UTCMINUS0600_CENTRAL_TIME_US_AND_CANADA -Connection $connection
}
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)

# parallel:
$timeStart = Get-Date
091..100 | ForEach-Object -Parallel {
    $title = "Test-Parallel-{0:000}" -f $_
    $Url = "https://uhgdev.sharepoint.com/teams/Test-Parallel-{0:000}" -f $_
    $owner = "vladilen@uhgdev.onmicrosoft.com"
    $template = "STS#3"
    $template = "SITEPAGEPUBLISHING#0"
    New-PnPTenantSite -Title $title -Url $url -Owner $owner -Template $template -TimeZone "6" -Connection $using:connection
    if ($?) { Write-Host "*" -ForegroundColor Green } else { Write-Host "0" -ForegroundColor Yellow }
} -ThrottleLimit 20
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.00}" -f ($timeElapsed.TotalSeconds / 10)


