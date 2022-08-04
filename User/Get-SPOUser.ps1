Connect-PnPOnline -Url $adminUrl -ClientId $clientId -ClientSecret $clientSc 

$connection.Url

Get-PnPAzureADUser 
Get-PnPAzureADUser | ? { $_.UserPrincipalname -match 11 } 
$users = Get-PnPAzureADUser | ? { $_.UserPrincipalname -match 11 } 
$users.count
$adUser = Get-PnPAzureADUser -Identity $users[2].UserPrincipalName -Select AdditionalProperties
$adUser = Get-PnPAzureADUser -Identity $users[2].UserPrincipalName
$adUser.AdditionalProperties
$adUser | fl


$UserProp = Get-PnPUserProfileProperty -Account $users[3].UserPrincipalName 
# $UserProp | fl
$UserProp.UserProfileProperties.'SPS-HideFromAddressLists'

$users | % { Get-PnPUserProfileProperty -Account $_.UserPrincipalname } | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }

Get-PnPUserProfileProperty -Account 'test-user-1101@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1102@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1103@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1104@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1105@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }
Get-PnPUserProfileProperty -Account 'test-user-1106@uhgdev.onmicrosoft.com' | % { $_.UserProfileProperties.'SPS-HideFromAddressLists' }

# Set-PnPUserProfileProperty -Account $users[4].UserPrincipalName -PropertyName 'SPS-HideFromAddressLists' -Value 'True'
Set-PnPUserProfileProperty -Account 'test-user-1105@uhgdev.onmicrosoft.com' -PropertyName 'SPS-HideFromAddressLists' -Value 'True'

#############################################################
# AzureAD

# auto:
# Connect-AzureAD -ApplicationId $clientID -TenantId $tenantId -CertificateThumbprint $certThumbprint
Connect-AzureAD 

Get-azureaduser 
Get-azureaduser -ObjectId test-user-1103@uhgdev.onmicrosoft.com | fl 
Get-azureaduser -ObjectId test-user-1105@uhgdev.onmicrosoft.com | fl 
$user = Get-azureaduser -ObjectId test-user-1105@uhgdev.onmicrosoft.com 
$user | fl
$user.tojson()
$user | fl | clip
$user.ShowInAddressList

Get-AzureADUser -ObjectId test-user-1104@uhgdev.onmicrosoft.com | Select -ExpandProperty ExtensionProperty

Get-AzureADUser -ObjectId test-user-1101@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1102@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1103@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1104@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1105@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList
Get-AzureADUser -ObjectId test-user-1106@uhgdev.onmicrosoft.com | Select -ExpandProperty ShowInAddressList

Set-AzureADUser -ObjectId test-user-1105@uhgdev.onmicrosoft.com -ShowInAddressList $false
Set-AzureADUser -ObjectId test-user-1105@uhgdev.onmicrosoft.com -ShowInAddressList 1

Set-AzureADUser -ObjectId test-user-1106@uhgdev.onmicrosoft.com -ShowInAddressList $false
Set-AzureADUser -ObjectId test-user-1106@uhgdev.onmicrosoft.com -ShowInAddressList $true

Get-AzureADApplication | Get-AzureADApplicationExtensionProperty

