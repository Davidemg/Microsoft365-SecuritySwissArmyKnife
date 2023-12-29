# Optional: Set the execution policy if needed and you have the required permissions
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install the ExchangeOnlineManagement module
# You might not need to run this every time, just ensure it's installed once
Install-Module -Name ExchangeOnlineManagement -Force
Install-Module -Name ExchangeOnlineManagement -Force
Install-Module -Name MSOnline -Force
Install-Module -Name AzureAD -Force
Install-Module -Name ExchangeOnline -Force

# Import the required modules
Import-Module ExchangeOnlineManagement   # For Connect-ExchangeOnline
Import-Module MSOnline                   # For Connect-MsolService
Import-Module AzureAD                    # For Connect-AzureAD
Import-Module ExchangeOnline              # For Connect-IPPSSession

try {
    # Connect to Exchange Online with interactive login
    Connect-ExchangeOnline -ShowProgress $true -ErrorAction Stop
    Write-Host "Connected to Exchange Online"

    # Connect to AzureAD with interactive login
    Connect-AzureAD -ErrorAction Stop
    Write-Host "Connected to Azure AD"

    # Connect to MS Online with interactive login
    Connect-MsolService -ErrorAction Stop
    Write-Host "Connected to MS Online"

    # Display basic information
    # For Exchange Online
    #$mailboxInfo = Get-Mailbox -Identity $credential.UserName
    #Write-Host "Exchange Online Mailbox Information: `n$mailboxInfo"

    # For Azure AD
    #$azureAdUser = Get-AzureADUser -ObjectId $credential.UserName
    #Write-Host "Azure AD User Information: `n$azureAdUser"

    # For MS Online
    #$msolUser = Get-MsolUser -UserPrincipalName $credential.UserName
    #Write-Host "Microsoft 365 User Information: `n$msolUser"
}
catch {
    # Handle any errors that occur during connection
    Write-Host "Error occurred: $($_.Exception.Message)"
}
finally {
    # Clean up resources or perform any necessary cleanup tasks here
}

function getDisconnected{
Disconnect-AzureAD

    Disconnect-MsolService
    Disconnect-ExchangeOnline -Confirm:$false
}