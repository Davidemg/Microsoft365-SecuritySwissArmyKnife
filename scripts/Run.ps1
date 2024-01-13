# Attempt to set the execution policy
try {
    Set-ExecutionPolicy RemoteSigned -ErrorAction Stop
} catch {
    Write-Host "Error setting execution policy. Please run as Administrator or modify the policy manually."
    exit
}

# Function to check if authentication is needed based on time elapsed
function Check-LastRunTime {
    $lastRunFile = ".\LastRunTime.txt"
    if (Test-Path $lastRunFile) {
        $lastRun = Get-Content $lastRunFile
        $lastRunTime = [DateTime]::ParseExact($lastRun, "yyyy-MM-dd HH:mm:ss", $null)
        $currentTime = Get-Date
        $timeDifference = $currentTime - $lastRunTime
        return $timeDifference.TotalMinutes -gt 20
    } else {
        return $true
    }
}

# Function to update the last run time
function Update-LastRunTime {
    $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Set-Content -Path ".\LastRunTime.txt" -Value $currentTime
}

# Check if authentication is needed
if (Check-LastRunTime) {
    $userChoice = Read-Host "Do you want to perform authentication? (default: Yes) [Y/N]"
    if ($userChoice -eq "" -or $userChoice.ToLower() -eq "y") {
        try {
            Write-Host "Attempting to establish necessary connections..." -ForegroundColor Cyan
            .\Make-Connections.ps1
            Write-Host "Connections established successfully.`n" -ForegroundColor Green
            Update-LastRunTime
        } catch {
            Write-Host "An error occurred while establishing connections: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "Skipping authentication as per user request."
    }
} else {
    Write-Host "Authentication was performed less than 20 minutes ago. No need to authenticate again."
}

# Import the Get-MFAStatus.ps1 script
. .\Get-MFAStatus.ps1

function Run-ShowMFAMenu {
    Write-Host "`nMFA Menu:"
    Write-Host "1: Get MFA Status for all users."
    Write-Host "2: Get MFA Status for specific users."
    Write-Host "3: Get users without MFA."
    Write-Host "4: Get MFA Status for admins only."
    Write-Host "5: Get MFA Status by country."
    Write-Host "6: Export users without MFA to CSV."
    Write-Host "R: Return to main menu.`n"

    $mfaSelection = Read-Host "Enter your choice for MFA tasks"
    switch ($mfaSelection) {
        '1' { Get-MFAStatus }
        '2' {
            $userList = Read-Host "Enter user principal names separated by commas"
            Get-MFAStatus -UserPrincipalName $userList.Split(',')
        }
        '3' { Get-MFAStatus -withOutMFAOnly }
        '4' { Get-MFAStatus -adminsOnly }
        '5' { 
            $countryCode = Read-Host "Enter country code (e.g., 'NL' for The Netherlands)"
            Get-MsolUser -Country $countryCode | ForEach-Object { Get-MFAStatus -UserPrincipalName $_.UserPrincipalName }
        }
        '6' { 
            Get-MFAStatus -withOutMFAOnly | Export-CSV $csvPath -noTypeInformation
            Write-Host "Exported to $csvPath"
        }
        'R' { break }
        default { Write-Host "Invalid choice, please try again." }
    }

}
while ($true) {

    # Present the user with options for further actions
    Write-Host "`nPlease select an option to continue:"
    Write-Host "1: Check MFA Status."
    Write-Host "2: Enable MFA for a User. (TODO)"
    Write-Host "3: Check Global Admins Count. (TODO)"
    Write-Host "4: List Azure AD Registered Devices. (TODO)"
    Write-Host "5: Check Mailbox Forwarding Status. (TODO)"
    Write-Host "6: List Activity Alerts. (TODO)"
    Write-Host "7: Check DLP Policies. (TODO)"
    Write-Host "8: Check Mailbox Auditing Status. (TODO)"
    Write-Host "9: Check Conditional Access Policies. (TODO)"
    Write-Host "10: Enable Mailbox Auditing. (TODO)"
    Write-Host "11: Disable Legacy Protocols for a Mailbox. (TODO)"
    Write-Host "12: Configure Anti-Spam Policies. (TODO)"
    Write-Host "13: Set Litigation Hold for a Mailbox. (TODO)"
    Write-Host "14: Check OAuth App Permissions. (TODO)"
    Write-Host "15: Enable Advanced Threat Protection. (TODO)"
    Write-Host "16: Configure Data Loss Prevention Policy. (TODO)"
    Write-Host "17: Block Sign-In for Shared Mailbox. (TODO)"
    Write-Host "18: Configure Mobile Device Policies.(TODO)"
    Write-Host "19: Adjust Outbound Spam Policies.(TODO)"
    Write-Host "20: Configure Alert Policies. (TODO)"
    Write-Host "21: Audit user creations from last 30 days (export to csv)."
    Write-Host "22: Show MFA Menu."
    Write-Host "23: Get Password Last Changed."
    Write-Host "24: Get Inactive Users from the Last 90 Days."
    Write-Host "25: Check Basic Authentication."
    Write-Host "26: Get Users and Tokens."  # Relevant line for option 26
    Write-Host "27: Get Mailboxes Where Status is Disabled."  # Relevant line for option 26
    Write-Host "28: Run Export Mailbox Permission Report."
    Write-Host "29: Run Simple Mailbox Permission Report."
    Write-Host "30: Get Mailbox Audit Status."
    Write-Host "31: Audit Mailbox Rules."
    Write-Host "32: Audit Mailbox Permission Changes."
    Write-Host "33: Office 365 spam and malware report to CSV"
    Write-Host "34: Show Users with Full Access"
    Write-Host "Q: Quit.`n"

    $selection = Read-Host "Enter your choice"
    switch ($selection) {
        '1' { .\Get-MFAStatus.ps1 }
        '2' { .\Enable-MFAForUser.ps1 }
        '3' { .\Get-GlobalAdminsCount.ps1 }
        '4' { .\Get-AzureADRegisteredDevices.ps1 }
        '5' { .\Get-MailboxForwardingStatus.ps1 }
        '6' { .\Get-ActivityAlerts.ps1 }
        '7' { .\Get-DLPPolicies.ps1 }
        '8' { .\Get-MailboxAuditingStatus.ps1 }
        '9' { .\Get-AzureADConditionalAccessPolicies.ps1 }
        '10' { .\Enable-MailboxAuditing.ps1 }
        '11' { .\Disable-LegacyProtocolsForMailbox.ps1 }
        '12' { .\Set-AntiSpamPolicies.ps1 }
        '13' { .\Set-LitigationHoldForMailbox.ps1 }
        '14' { .\Get-OAuthAppPermissions.ps1 }
        '15' { .\Enable-AdvancedThreatProtection.ps1 }
        '16' { .\Set-DataLossPreventionPolicy.ps1 }
        '17' { .\Block-SignInForSharedMailbox.ps1 }
        '18' { .\Set-MobileDevicePolicies.ps1 }
        '19' { .\Adjust-OutboundSpamPolicies.ps1 }
        '20' { .\Set-AlertPolicies.ps1 }
        '21' { .\Audit-M365UserCreations.ps1 }
        '22' { Run-ShowMFAMenu }
        '23' { .\Get-PasswordLastChanged.ps1 }
        '24' { .\Get-InactiveUsersLast90Days.ps1 }
        '25' { .\Check-BasicAuthentication.ps1 }
        '26' { .\Get-UsersAndTokens.ps1 }
        '27' { .\Get-MailboxesWhereAuditDisabled.ps1 }
        '28' { .\Export-MailboxPermissionReport.ps1 }
        '29' { .\Export-SimpleMailboxPermissionReport.ps1 }
        '30' { .\Get-MailboxAuditInfo.ps1 }
        '31' { .\Audit-MailboxRules.ps1 }
        '32' { .\Audit-MailboxPermissionChanges.ps1 }
        '33' { .\Show-MailProtectionReportMenu.ps1 }
        '34' { .\Get-UsersWithFullAccess.ps1 }
        'Q' { 
            Write-Host "Exiting script."
            break
        }
        default { Write-Host "Invalid choice, please try again." }
    }
   # Pause before showing the menu again
    Write-Host "Press Enter to return to the main menu..."
    Read-Host
}