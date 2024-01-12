function Get-AzureADConditionalAccessPolicies {
    try {
        # Connect to Azure AD
        Connect-AzureAD | Out-Null

        # Retrieve all Conditional Access policies
        $conditionalAccessPolicies = Get-AzureADMSConditionalAccessPolicy

        # Initialize an array to hold custom objects
        $policyDetails = @()

        # Process each policy and add to the array
        foreach ($policy in $conditionalAccessPolicies) {
            # Fetch display names for included users
            $includeUserNamesString = if ($policy.Conditions.Users.IncludeUsers -and $policy.Conditions.Users.IncludeUsers -ne 'All') {
                ($policy.Conditions.Users.IncludeUsers | ForEach-Object {
                    try {
                        (Get-AzureADUser -ObjectId $_).DisplayName
                    } catch {
                        $_.Exception.Message
                    }
                }) -join ', '
            } else {
                'All'
            }

            # Fetch display names for excluded users
            $excludeUserNamesString = if ($policy.Conditions.Users.ExcludeUsers) {
                ($policy.Conditions.Users.ExcludeUsers | ForEach-Object {
                    try {
                        (Get-AzureADUser -ObjectId $_).DisplayName
                    } catch {
                        $_.Exception.Message
                    }
                }) -join ', '
            } else {
                ''
            }

            # Fetch display names for applications
            $applicationNamesString = if ($policy.Conditions.Applications.IncludeApplications -and $policy.Conditions.Applications.IncludeApplications -ne 'All') {
                ($policy.Conditions.Applications.IncludeApplications | ForEach-Object {
                    try {
                        (Get-AzureADServicePrincipal -ObjectId $_).DisplayName
                    } catch {
                        $_.Exception.Message
                    }
                }) -join ', '
            } else {
                'All'
            }

            $details = New-Object PSObject -Property @{
                Id              = $policy.Id
                DisplayName     = $policy.DisplayName
                Applications    = $applicationNamesString
                Users           = $includeUserNamesString
                ExcludeUsers    = $excludeUserNamesString
                GrantControls   = ("Operator: " + $policy.GrantControls._Operator + "; Controls: " + ($policy.GrantControls.BuiltInControls -join ', '))
            }
            $policyDetails += $details
        }

        # Output in the terminal
        $policyDetails | Format-Table -AutoSize

        # Ask the user if they want to see the policies in GridView
        $userChoice = Read-Host "Do you want to see the policies in GridView? (Y/N)"
        


      # Check user choice and display output accordingly
        if ($userChoice -eq 'Y' -or $userChoice -eq 'y') {
            $policyDetails | Out-GridView -Title "Azure AD Conditional Access Policies"
        } else {
            Write-Host "No Out-GridView selected."
            Write-Host "Showing formatted table instead:"
            $policyDetails | Format-Table -AutoSize
        }

        # Ask the user if they want to export the data to CSV
        $userChoiceCSV = Read-Host "Do you want to export the data to CSV? (Y/N)"

        # Check user choice and export to CSV accordingly
        if ($userChoiceCSV -eq 'Y' -or $userChoiceCSV -eq 'y') {
            $policyDetails | Export-CSV "ConditionalAccessPolicies.csv" -NoTypeInformation
            Write-Host "Exported policy data to ConditionalAccessPolicies.csv"
        } else {
            Write-Host "No CSV export selected."
        }


    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

# To run the function
Get-AzureADConditionalAccessPolicies
