# Install Exchange Online PowerShell module if not already installed
if (-not (Get-Module -Name ExchangeOnlineManagement -ListAvailable)) {
    Install-Module ExchangeOnlineManagement -Force
}

# Import the module
Import-Module ExchangeOnlineManagement

# Connect to Outlook Online using Exchange Online PowerShell module
Connect-ExchangeOnline

# Prompt the user to enter the folder name (Read-Host "Enter the name of the folder you want to connect to")
$folderName = 'Inbox'

# Get the specified folder
#$folder = Get-EXOMailboxFolderStatistics -FolderScope All -Identity $folderName
$folder = Get-EXOMailboxFolderStatistics -FolderScope $folderName -Identity 'username@domain.com'
if ($folder -eq $null) {
    Write-Host "The specified folder could not be found." -ForegroundColor Red
    Exit
}

# Print the folder information
Write-Host "Folder information:"
Write-Host "  Folder name: $($folder.Identity)"
Write-Host "  Folder type: $($folder.FolderPath)"
Write-Host "  Number of items: $($folder.VisibleItemsInFolder)"
