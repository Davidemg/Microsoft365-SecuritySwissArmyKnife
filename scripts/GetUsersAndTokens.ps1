function Get-ActiveUserTokens {
    try {
        # Get all Azure AD users
        $users = Get-AzureADUser -All $true -ErrorAction Stop

        # Display the data in the terminal
        $users | Format-List DisplayName, UserPrincipalName, RefreshTokensValidFromDateTime, ProxyAddresses

        # Ask the user if they want to see the data in GridView
        $userChoiceGridView = Read-Host "Do you want to see the data in GridView? (Y/N)"

        if ($userChoiceGridView -eq 'Y' -or $userChoiceGridView -eq 'y') {
            $users | Out-GridView -Title "Azure AD Users"
        }

        # Ask the user if they want to export the data to CSV
        $userChoiceCSV = Read-Host "Do you want to export the data to CSV? (Y/N)"

        if ($userChoiceCSV -eq 'Y' -or $userChoiceCSV -eq 'y') {
            # Export to CSV
            $users | Export-CSV "AzureADUsers.csv" -NoTypeInformation
            Write-Host "Exported user data to AzureADUsers.csv"
        } else {
            Write-Host "No CSV export selected."
        }
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

# Main script execution
function Run-SecuritySetup {
    # Call each function here
    Write-Host `n 
    Write-Host "...Running GetUsersAndTokens.ps1" 

    # Call the functions one by one
    Get-ActiveUserTokens 

    Write-Host "...Script GetUsersAndTokens.ps1 Completed."
}

# Uncomment the following line to execute the script when the script is run.
Run-SecuritySetup
