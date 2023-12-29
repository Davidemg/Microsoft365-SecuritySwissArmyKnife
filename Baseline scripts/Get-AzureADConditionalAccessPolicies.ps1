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

        # Output in Out-GridView
        $policyDetails | Out-GridView -Title "Azure AD Conditional Access Policies"

        # Export to CSV
        $policyDetails | Export-CSV "ConditionalAccessPolicies.csv" -NoTypeInformation
        Write-Host "Exported policy data to ConditionalAccessPolicies.csv"

    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

# To run the function
Get-AzureADConditionalAccessPolicies
