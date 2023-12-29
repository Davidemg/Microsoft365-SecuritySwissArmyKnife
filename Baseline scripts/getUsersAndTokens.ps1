function Get-ActiveUserTokens {
# Get all Azure AD users
        $users = Get-AzureADUser -All $true -ErrorAction Stop
       # Write-Host $users | FL DisplayName, UserPrincipalName, RefreshTokensValidFromDateTime, ProxyAddresses 
        Write-Host Get-AzureADUser | FL DisplayName, UserPrincipalName, RefreshTokensValidFromDateTime, ProxyAddresses 
}



# Main script execution
function Run-SecuritySetup {
    # Call each function here
    Write-Host `n 
    Write-Host "...Running Security Setup" 

    # Call the functions one by one
    Get-ActiveUserTokens 
    #Get-AzureADUser | Out-GridView


    Write-Host "...Script Completed."
}

# Uncomment the following line to execute the script when the script is run.
Run-SecuritySetup 