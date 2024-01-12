function Show-MailboxAuditInfo {
    try {
        # Retrieve mailbox audit information
        $mailboxAuditInfo = Get-Mailbox | Select-Object UserPrincipalName, AuditEnabled, AuditDelegate, AuditAdmin, AuditLogAgeLimit

        # Display the information in a grid view
        $mailboxAuditInfo | Out-GridView -Title "Mailbox Audit Information"
    }
    catch {
        # Check if the error message contains 'Get-Mailbox' not recognized
        if ($_.Exception.Message -match 'Get-Mailbox is not recognized') {
            Write-Host "Running 'GetConnected.ps1' to establish a connection..."
            # Run the 'GetConnected.ps1' script here
            & GetConnected.ps1
            Write-Host "Connection established. Re-running 'Show-MailboxAuditInfo'..."
            # Retry running the 'Show-MailboxAuditInfo' function
            Show-MailboxAuditInfo
        }
        else {
            Write-Error "An error occurred: $_"
        }
    }
}

# To run the function
Show-MailboxAuditInfo
