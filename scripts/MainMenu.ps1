Set-ExecutionPolicy RemoteSigned

. .\Get-MFAStatus.ps1

    # Present the user with options for further actions
    Write-Host "`nPlease select an option to continue:"
    Write-Host "1: Check MFA Status."
    Write-Host "2: Enable MFA for a User."
    Write-Host "3: Check Global Admins Count."
    Write-Host "4: List Azure AD Registered Devices."
    Write-Host "5: Check Mailbox Forwarding Status."
    Write-Host "6: List Activity Alerts."
    Write-Host "7: Check DLP Policies."
    Write-Host "8: Check Mailbox Auditing Status."
    Write-Host "9: Check Conditional Access Policies."
    Write-Host "10: Enable Mailbox Auditing."
    Write-Host "11: Disable Legacy Protocols for a Mailbox."
    Write-Host "12: Configure Anti-Spam Policies."
    Write-Host "13: Set Litigation Hold for a Mailbox."
    Write-Host "14: Check OAuth App Permissions."
    Write-Host "15: Enable Advanced Threat Protection."
    Write-Host "16: Configure Data Loss Prevention Policy."
    Write-Host "17: Block Sign-In for Shared Mailbox."
    Write-Host "18: Configure Mobile Device Policies."
    Write-Host "19: Adjust Outbound Spam Policies."
    Write-Host "20: Configure Alert Policies."
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
    Write-Host "33: Show Users with Full Access"
    Write-Host "Q: Quit.`n"

    $selection = Read-Host "Enter your choice"
    switch ($selection) {
        '1' { .\CheckMFAStatus.ps1 }
        '2' { .\EnableMFAForUser.ps1 }
        '3' { .\CheckGlobalAdminsCount.ps1 }
        '4' { .\ListAzureADRegisteredDevices.ps1 }
        '5' { .\CheckMailboxForwardingStatus.ps1 }
        '6' { .\ListActivityAlerts.ps1 }
        '7' { .\CheckDLPPolicies.ps1 }
        '8' { .\CheckMailboxAuditingStatus.ps1 }
        '9' { .\Get-AzureADConditionalAccessPolicies.ps1 }
        '10' { .\EnableMailboxAuditing.ps1 }
        '11' { .\DisableLegacyProtocolsForMailbox.ps1 }
        '12' { .\ConfigureAntiSpamPolicies.ps1 }
        '13' { .\SetLitigationHoldForMailbox.ps1 }
        '14' { .\CheckOAuthAppPermissions.ps1 }
        '15' { .\EnableAdvancedThreatProtection.ps1 }
        '16' { .\ConfigureDataLossPreventionPolicy.ps1 }
        '17' { .\BlockSignInForSharedMailbox.ps1 }
        '18' { .\ConfigureMobileDevicePolicies.ps1 }
        '19' { .\AdjustOutboundSpamPolicies.ps1 }
        '20' { .\ConfigureAlertPolicies.ps1 }
        '21' { .\AuditM365UserCreations.ps1 }  # New option for auditing user creations
        '22' { 
            # Import the Get-MFAStatus.ps1 script
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
        '23' { 
            # Run Get-PasswordLastChanged.ps1 script
            .\Get-PasswordLastChanged.ps1
        }
        '24' { 
            # Run InactiveUsersLast90Days.ps1 script
            .\InactiveUsersLast90Days.ps1
        }
        '25' { 
            # Run CheckBasicAuth.ps1 script
            .\CheckBasicAuth.ps1
        }
        '26' { 
            # Get Users and Tokens
            .\GetUsersAndTokens.ps1
        }
        '27' { 
            # Get Mailboxes Where Audit is Disabled
            .\CheckMailboxWhereAuditDisabled.ps1
        }
        '28' { 
            # Run Export Mailbox Permission Report
            .\GetMailBoxPermission.ps1
        }
        '29' { 
            # Run Export Mailbox Permission Report
            .\GetMailboxPermissionSimple.ps1
        }
        '30' { 
            # Show MailboxAuditInfo
            .\Show-MailboxAuditInfo.ps1
        }
        '31' { 
            # Show AuditMailboxRules
            .\AuditMailboxRules.ps1
        }
        '32' { 
            # Show AuditMailboxRules
            .\AuditMailboxPermissionChanges.ps1
        }
        '33' { 
            Write-Host "`nMail Protection Report Menu:"
            Write-Host "1: Spam Emails Received Report."
            Write-Host "2: Malware Emails Received Report."
            Write-Host "3: Phishing Emails Received Report."
            Write-Host "4: Spam Emails Sent Report."
            Write-Host "5: Malware Emails Sent Report."
            Write-Host "6: Phishing Emails Sent Report."
            Write-Host "7: Intra-Organizational Spam Emails."
            Write-Host "8: Intra-Organizational Malware Emails."
            Write-Host "9: Intra-Organizational Phishing Emails."
            Write-Host "R: Return to main menu.`n"

            $mailProtectionSelection = Read-Host "Enter your choice for Mail Protection Reports"
            switch ($mailProtectionSelection) {
                '1' { .\MailProtectionReport.ps1 -SpamEmailsReceived }
                '2' { .\MailProtectionReport.ps1 -MalwareEmailsReceived }
                '3' { .\MailProtectionReport.ps1 -PhishEmailsReceived }
                '4' { .\MailProtectionReport.ps1 -SpamEmailsSent }
                '5' { .\MailProtectionReport.ps1 -MalwareEmailsSent }
                '6' { .\MailProtectionReport.ps1 -PhishEmailsSent }
                '7' { .\MailProtectionReport.ps1 -IntraOrgSpamMails }
                '8' { .\MailProtectionReport.ps1 -IntraOrgMalwareMails }
                '9' { .\MailProtectionReport.ps1 -IntraOrgPhishMails }
                'R' { break }
                default { Write-Host "Invalid choice, please try again." }
            }     
        }
        '34' { 
            # Show Users with Full Access
            .\GetUsersWithFullAccess.ps1
        }
        'Q' { 
            Write-Host "Exiting script."
            $scriptRunning = $false
        }
        default { Write-Host "Invalid choice, please try again." }
    }



    