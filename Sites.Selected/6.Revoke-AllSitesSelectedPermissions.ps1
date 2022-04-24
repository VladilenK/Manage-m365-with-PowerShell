# specify Client site Id and obtain Access Token
$clientSiteId
$AccessToken.Substring(0, 3)

# get permissions with 3.Get-SitesSelectedPermissions.ps1
$permissions | Format-Table -AutoSize Role, AppName, Id
# Select permission to delete
$revoked = @()
foreach ($permission in $permissions) {
    # $permission = $permissions[0]; $permission | fl    
    $apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $clientSiteId + '/permissions/' + $permission.Id
    $revoked += Invoke-RestMethod -Headers @{Authorization = "Bearer $($AccessToken)" } -Uri $apiUrl -Method Delete
}
$revoked
