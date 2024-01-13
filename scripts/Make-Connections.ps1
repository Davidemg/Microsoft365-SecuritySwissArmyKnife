# Set the execution policy for the current user, if necessary and permitted
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -ErrorAction SilentlyContinue

# Function to check and install modules
function CheckAndInstallModule {
    param (
        [string]$moduleName
    )
    if (-not (Get-Module -ListAvailable -Name $moduleName)) {
        Install-Module -Name $moduleName -Force
        Write-Host "Installed module: $moduleName"
    }
    else {
        Write-Host "Module already installed: $moduleName"
    }
}

# Check and install required modules
CheckAndInstallModule -moduleName "ExchangeOnlineManagement"
CheckAndInstallModule -moduleName "MSOnline"
CheckAndInstallModule -moduleName "AzureAD"

# Import the required modules if they are not already loaded
Import-Module ExchangeOnlineManagement -ErrorAction SilentlyContinue
Import-Module MSOnline -ErrorAction SilentlyContinue
Import-Module AzureAD -ErrorAction SilentlyContinue
Import-Module ExchangeOnline -ErrorAction SilentlyContinue

try {
    # Attempt to connect to each service
    Connect-ExchangeOnline -ShowProgress $true -ErrorAction Stop
    Write-Host "Connected to Exchange Online successfully."

    Connect-AzureAD -ErrorAction Stop
    Write-Host "Connected to Azure AD successfully."

    Connect-MsolService -ErrorAction Stop
    Write-Host "Connected to MS Online successfully."

    Connect-IPPSSession -ErrorAction Stop
    Write-Host "Connected to Security & Compliance successfully. `n"

    # Display basic information for each service
    $mailboxCount = Get-Mailbox | Measure-Object
    Write-Host "Number of mailboxes in Exchange Online: $($mailboxCount.Count)"

    $azureAdUserCount = Get-AzureADUser | Measure-Object
    Write-Host "Number of users in Azure AD: $($azureAdUserCount.Count)"

    $msolUserCount = Get-MsolUser | Measure-Object
    Write-Host "Number of users in Microsoft 365: $($msolUserCount.Count)"
}
catch {
    # Specific error handling for each connection attempt
    Write-Host "Error occurred: $($_.Exception.Message)"
}
finally {
    # Perform cleanup tasks
    # Add your disconnect commands here if necessary


    }
