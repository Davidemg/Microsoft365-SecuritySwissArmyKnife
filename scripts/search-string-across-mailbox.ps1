# Connect to Office 365 using Exchange Online Remote PowerShell Module
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

# Define variables for the mailbox to search and the string to search for
$mailbox = "davide@cyberplate.be"
$searchString = "knowbe4"


# Define a search filter to find emails containing the search string
$searchFilter = New-Object Microsoft.Exchange.WebServices.Data.SearchFilter+ContainsSubstring([Microsoft.Exchange.WebServices.Data.ItemSchema]::Body, $searchString)


# Search for emails in the mailbox containing the search string
$searchResults = Search-Mailbox -Identity $mailbox -SearchQuery $searchFilter -EstimateResultOnly

# Count the number of times the search string appears in the search results
$count = 0
foreach ($result in $searchResults) {
    $count += ([regex]::Matches($result.Body, $searchString)).Count
}

# Display the count of the search string
Write-Host "The search string '$searchString' was found $count times in the mailbox of $mailbox."