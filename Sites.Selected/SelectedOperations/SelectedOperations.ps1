# with this script we provide granular access for application to SharePoint - e.g. to list/folder/item (SelectedOperations)


# specify Tenant Id and tardet site Url
$TenantId = "" 
$targetSiteId = "contoso.sharepoint.com:/teams/Test-Sites-Selected" 

# specify Admin's app client Id and secret
$clientId = ""
$clientSc = ""

Write-Host "ClientId:" $clientId
Write-Host "TenantId:" $TenantId
Write-Host "ClientSc:" $clientSc.Substring(0,3)

# Authenticate as admin
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $clientId
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $clientSc
    grant_type    = "client_credentials" 
}
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
$token = $tokenRequest.Content | ConvertFrom-Json
$token.expires_in
$accessToken = $token.access_token
$headers = @{Authorization = "Bearer $accessToken" }
$headers | ft -a


# Validate access - Get target site
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$response | Format-List

# get target site lists
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$lists = $response.value
$lists | Format-Table id, name

# get target site list items
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists/$targetSiteListId/items"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$response.value | Format-Table id
$response.value[0]

# get permissions for the app to the site
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/permissions"
$apiUrl = "https://graph.microsoft.com/beta/sites/$targetSiteId/permissions"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$response.value | Format-Table

# get permissions (for the app) to the list
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists/$targetSiteListId/permissions"
$apiUrl = "https://graph.microsoft.com/beta/sites/$targetSiteId/lists/$targetSiteListId/permissions"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$response.value 
$response.value[-1] | fl
$response.value[-1].roles
$response.value[-1].grantedTo.application.id
$response.value[-1].grantedToV2

# provide permissions for the app to the list
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists/$targetSiteListId/permissions"
$apiUrl = "https://graph.microsoft.com/beta/sites/$targetSiteId/lists/$targetSiteListId/permissions"
$apiUrl 
$params = @{
	roles = @(
	    "read"
    )
    grantedTo = @{
        application = @{
            id = $clientAppClientId
        }
    }
}
$body = $params | ConvertTo-Json
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Post -Body $body -ContentType "application/json"
$response

# Remove the permissions on a specific list
$permissionId = "aTowaS50fG1zLnNwLmV4dHwwNmEzMGIxMS05YjdhLTRmMDYtOGVjOS05NGE2YzFkMGE0ZjRAODg3ZDY2MGUtYzUzZi00YzM4LWFmNjktMjE0ZmUyYTczZjBh"
$apiUrl = "https://graph.microsoft.com/beta/sites/$targetSiteId/lists/$targetSiteListId/permissions/$permissionId"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Delete
$response




