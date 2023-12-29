

function Get-AuthPolicies {
    # Get all existing authentication policies
    $authPolicies = Get-AuthenticationPolicy

    # Check if there are any policies
    if ($authPolicies -ne $null -and $authPolicies.Count -gt 0) {
        Write-Output "Checking for authentication policies.."
        Write-Output "Found" + $authPolicies
        # Output the details of each policy
        foreach ($policy in $authPolicies) {
            Write-Output "Policy Name: $($policy.Name)"
            Write-Output "Allow Basic Auth RPC: $($policy.AllowBasicAuthRpc)"
            Write-Output "Allow Basic Auth POP: $($policy.AllowBasicAuthPop)"
            Write-Output "Allow Basic Auth SMTP: $($policy.AllowBasicAuthSmtp)"
            Write-Output "Allow Basic Auth MAPI: $($policy.AllowBasicAuthMapi)"
            Write-Output "Allow Basic Auth IMAP: $($policy.AllowBasicAuthImap)"
            Write-Output "Allow Basic Auth Autodiscover: $($policy.AllowBasicAuthAutodiscover)"
            Write-Output "Allow Basic Auth PowerShell: $($policy.AllowBasicAuthPowershell)"
            Write-Output "Allow Basic Auth ActiveSync: $($policy.AllowBasicAuthActiveSync)"
            Write-Output "Allow Basic Auth Offline Address Book: $($policy.AllowBasicAuthOfflineAddressBook)"
            Write-Output "Allow Basic Auth Reporting Web Services: $($policy.AllowBasicAuthReportingWebServices)"
            Write-Output "Allow Basic Auth Outlook Service: $($policy.AllowBasicAuthOutlookService)"
            Write-Output "Allow Basic Auth Web Services: $($policy.AllowBasicAuthWebServices)"
            Write-Output "--------------------------------"
        }
    } else {
        Write-Output "No authentication policies found."
        #Get-AuthenticationPolicy
    }
}

function Get-AuthPolicies {
    try {

        # Attempt to get all existing authentication policies
        $authPolicies = Get-AuthenticationPolicy -ErrorAction Stop

        # Check if there are any policies
        Write-Output "...Checking for authentication policies" 

        if ($authPolicies -ne $null){
            Write-Output "...Policy found!" `n
        }

        if ($authPolicies -ne $null -and $authPolicies.Count -gt 0) {
            # Output the details of each policy
            foreach ($policy in $authPolicies) {
                Write-Output "Policy Name: $($policy.Name)"
                Write-Output "Allow Basic Auth RPC: $($policy.AllowBasicAuthRpc)"
                Write-Output "Allow Basic Auth POP: $($policy.AllowBasicAuthPop)"
                Write-Output "Allow Basic Auth SMTP: $($policy.AllowBasicAuthSmtp)"
                Write-Output "Allow Basic Auth MAPI: $($policy.AllowBasicAuthMapi)"
                Write-Output "Allow Basic Auth IMAP: $($policy.AllowBasicAuthImap)"
                Write-Output "Allow Basic Auth Autodiscover: $($policy.AllowBasicAuthAutodiscover)"
                Write-Output "Allow Basic Auth PowerShell: $($policy.AllowBasicAuthPowershell)"
                Write-Output "Allow Basic Auth ActiveSync: $($policy.AllowBasicAuthActiveSync)"
                Write-Output "Allow Basic Auth Offline Address Book: $($policy.AllowBasicAuthOfflineAddressBook)"
                Write-Output "Allow Basic Auth Reporting Web Services: $($policy.AllowBasicAuthReportingWebServices)"
                Write-Output "Allow Basic Auth Outlook Service: $($policy.AllowBasicAuthOutlookService)"
                Write-Output "Allow Basic Auth Web Services: $($policy.AllowBasicAuthWebServices)"
                Write-Output "--------------------------------"
            }
        } elseif ($authPolicies -ne $null) {
                Write-Output "Policy Name: $($authPolicies.Name)"
                Write-Output "Allow Basic Auth RPC: $($authPolicies.AllowBasicAuthRpc)"
                Write-Output "Allow Basic Auth POP: $($authPolicies.AllowBasicAuthPop)"
                Write-Output "Allow Basic Auth SMTP: $($authPolicies.AllowBasicAuthSmtp)"
                Write-Output "Allow Basic Auth MAPI: $($authPolicies.AllowBasicAuthMapi)"
                Write-Output "Allow Basic Auth IMAP: $($authPolicies.AllowBasicAuthImap)"
                Write-Output "Allow Basic Auth Autodiscover: $($authPolicies.AllowBasicAuthAutodiscover)"
                Write-Output "Allow Basic Auth PowerShell: $($authPolicies.AllowBasicAuthPowershell)"
                Write-Output "Allow Basic Auth ActiveSync: $($authPolicies.AllowBasicAuthActiveSync)"
                Write-Output "Allow Basic Auth Offline Address Book: $($authPolicies.AllowBasicAuthOfflineAddressBook)"
                Write-Output "Allow Basic Auth Reporting Web Services: $($authPolicies.AllowBasicAuthReportingWebServices)"
                Write-Output "Allow Basic Auth Outlook Service: $($authPolicies.AllowBasicAuthOutlookService)"
                Write-Output "Allow Basic Auth Web Services: $($authPolicies.AllowBasicAuthWebServices)"
                Write-Output "--------------------------------"
        } else {
            Write-Output "No authentication policies found." `n
        }
    } catch {
        Write-Error "An error occurred: $_"
    }

    $SMTPAUTH = Get-TransportConfig | Format-List SmtpClientAuthenticationDisabled
    Write-Output "...checking if SMTP AUTH is globally disabled in your organization"
    Write-Output  $SMTPAUTH 
}


# Function to disable Legacy Protocols and Basic Authentication
function Disable-LegacyProtocols {
    # Code to disable legacy protocols
    # Log and handle errors

}

function Show-Grid {
    # Ask the user if they want to see the result in GridView
    $userChoice = Read-Host "Do you want to see the policies in GridView? (Y/N)" `n


    # Check user choice and display output
    if ($userChoice -eq 'Y'-or $UserChoice -eq 'y') {
        Get-AuthenticationPolicy | Out-GridView
    } else {
        Write-Host `n 
        Write-Output "...No Out-GridView selected" 
        Write-Output "...Showing formatted table instead" 
        $FL = Get-AuthenticationPolicy | FL *
        Write-Output $FL
    }
  }

# Main script execution
function Run-SecuritySetup {
    # Call each function here
    Write-Host `n 
    Write-Host "...Running Security Setup" 

    # Call the functions one by one
    Get-AuthPolicies
    #Disable-LegacyProtocols
    Show-Grid

    Write-Host "...Script Completed."
}

# Uncomment the following line to execute the script when the script is run.
Run-SecuritySetup 