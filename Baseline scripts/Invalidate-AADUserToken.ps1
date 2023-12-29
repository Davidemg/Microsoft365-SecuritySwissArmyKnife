function Invalidate-AADUserToken {
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Enter the UserPrincipalName of the user.")]
        [string]$UserPrincipalName
    )

    try {
        # Connect to MSOnline service if not already connected
        $isConnected = Get-MsolDomain -ErrorAction SilentlyContinue
        if (-not $isConnected) {
            Connect-MsolService
        }

        # Invalidate the user's token
        $date = Get-Date
        Set-MsolUser -UserPrincipalName $UserPrincipalName -StsRefreshTokensValidFrom $date

        Write-Host "Tokens for user '$UserPrincipalName' have been invalidated as of $date" -ForegroundColor Green
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

# Example usage:
# Invalidate-AADUserToken -UserPrincipalName "user@domain.com"
