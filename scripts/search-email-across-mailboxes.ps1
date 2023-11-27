# Connect to Office 365 using Exchange Online Remote PowerShell Module
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

# Define the search query to find the specific emails
$searchQuery = 'Subject:"Perdoo"'

# Define a variable to hold the search results
$searchResults = @()

# Get a list of all mailboxes in Office 365
$mailboxes = Get-EXOMailbox -ResultSize unlimited

# Loop through each mailbox and search for the specific emails
foreach ($mailbox in $mailboxes) {
    $mailboxEmail = $mailbox.PrimarySmtpAddress.ToString()
    Write-Host "Searching mailbox $mailboxEmail"
    $mailboxResults = Search-Mailbox -Identity $mailboxEmail -SearchQuery $searchQuery -EstimateResultOnly
    if ($mailboxResults.ResultItemsCount -gt 0) {
        $searchResults += $mailboxResults
    }
}

# Display the search results
$searchResults